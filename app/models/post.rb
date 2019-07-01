class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :commenters, through: :comments, class_name: "User", source: :commenter
    belongs_to :author, class_name: "User"
    validates :title, presence: true, uniqueness: { scope: :author_id }
    validates :body, presence: true    
end
