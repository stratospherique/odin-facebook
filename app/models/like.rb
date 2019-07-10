class Like < ApplicationRecord
    after_save do |like|
        unless like.liked_post.author == like.liker
            notif = like.liked_post.author.notifications.build
            notif.message = "#{like.liker.name} has liked your post"
            notif.save
        end 
    end
    belongs_to :liker, class_name: "User"
    belongs_to :liked_post, class_name: "Post"
    validates :liker_id, uniqueness: {scope: :liked_post_id}
end
