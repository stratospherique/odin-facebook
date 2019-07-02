class User < ApplicationRecord
  has_one :profile, dependent: :destroy
  has_many :posts, foreign_key: "author_id"
  has_many :comments, foreign_key: "commenter_id"
  has_many :commented_posts, through: :comments, class_name: "Post", source: :post
  has_many :likes, foreign_key: "liker_id"
  has_many :liked_posts, through: :likes, class_name: "Post"
  

  #friendship association
  has_many :invitations, foreign_key: :invitee_id
  # retrieve the users to whom a user has sent a friend request
  has_many :pals, through: :invitations, class_name: "User", source: :invited
  has_many :requests,foreign_key: :invited_id, class_name: "Invitation"
  # retrieve the users from which a user got friend request
  has_many :users, through: :requests, source: :invitee
  
  def friends
    self.invitations.where(status: "accepted").map{|x| x.invited} + self.requests.where(status: "accepted").map{|x| x.invitee}
  end
  validates :first_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :password_confirmation, presence: true
  
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  def name
    [first_name, last_name].join(' ')
  end

end
