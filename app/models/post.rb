class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    has_many :commenters, through: :comments, class_name: "User", source: :commenter
    belongs_to :author, class_name: "User"
    has_many :likes,dependent: :destroy, foreign_key: "liked_post_id"
    has_many :likers, through: :likes, class_name: "User"
    validates :title, presence: true, uniqueness: { scope: :author_id }
    validates :body, presence: true

    def nb_likes
        self.likes.count
    end

    def nb_comments
        self.comments.count
    end

    def since?
        time_since(self.updated_at)
    end
    
    private 
    def time_since(post_date)
        diff = Time.now - post_date
        case diff
        when (3600 * 24)..Float::INFINITY
            "#{(diff / (3600 * 24)).floor} days"
        when 3599..(3600 * 24 - 1)
            "#{(diff / 3600).floor} hours"
        when 60..3600
            "#{(diff / 60).floor} minutes"
        when 10..60
            "#{diff.floor} seconds"
        else 'Now'
        end
    end
end
