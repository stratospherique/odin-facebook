class User < ApplicationRecord
  before_save do |user|
    unless user.uid
      user.image = gravatar_for(user)
     
    end
  end
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

  def pending_friends
    self.invitations.where(status: "pending").map{ |x| x.invited } #+ self.requests.where(status: "pending").map{ |x| x.invitee }   
  end

  def accept_friends
    self.requests.where(status: "pending").map{ |x| x.invitee }
  end

  # notification  for comment and likes on posts
  has_many :notifications

  # validations ==============================
  validates :first_name, presence: true, length: {minimum: 4}
  validates :last_name, presence: true, length: {minimum: 4}
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
      user.first_name = auth.info.name
      user.last_name = auth.info.name
      user.image = auth.info.image
      # assuming the user model has a name
      # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def gravatar_for(user, size: 40)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

end
