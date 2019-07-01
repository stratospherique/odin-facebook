class User < ApplicationRecord
  has_many :posts, foreign_key: "author_id"
  has_one :profile, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :first_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :last_name, presence: true, length: {minimum: 4, maximum: 20}
  validates :password_confirmation, presence: true
  
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  def name
    [first_name, last_name].join(' ')
  end

end
