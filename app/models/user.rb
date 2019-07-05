class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy, foreign_key: "author_id"
  has_many :comments, dependent: :destroy ,foreign_key: "commenter_id"
  has_many :commented_posts, through: :comments, class_name: "Post", source: :post
  has_many :likes, foreign_key: "liker_id"
  has_many :liked_posts, through: :likes, class_name: "Post"
  

  #friendship association
  has_many :invitations, dependent: :destroy ,foreign_key: :invitee_id
  # retrieve the users to whom a user has sent a friend request
  has_many :pals, through: :invitations, class_name: "User", source: :invited
  has_many :requests, dependent: :destroy ,foreign_key: :invited_id, class_name: "Invitation"
  # retrieve the users from which a user got friend request
  has_many :users, through: :requests, source: :invitee
  
  def friends
    self.invitations.where(status: "accepted").map{|x| x.invited} + self.requests.where(status: "accepted").map{|x| x.invitee}
  end
  validates :first_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :password_confirmation, presence: true
  
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: %i[facebook]

  def name
    [first_name, last_name].join(' ')
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.password_confirmation = user.password
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      # assuming the user model has a name
      # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      
    end
  end

  def self.get_image(auth)
    auth.info.image
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

end
