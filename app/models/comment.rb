class Comment < ApplicationRecord
    after_save do |comment|
        unless comment.post.author == comment.commenter
            notif = comment.post.author.notifications.build
            notif.message = "#{comment.commenter.name} has commented on your post"
            notif.save 
        end
    end
    belongs_to :commenter, class_name: "User"
    belongs_to :post
    validates :body, presence: true
end
