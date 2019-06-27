class Post < ApplicationRecord
    belongs_to :author, class_name: "User"
    validates :title, presence: true, uniqueness: { scope: :author_id }
    validates :body, presence: true    
end
