class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :liked_post_id
      t.integer :liker_id

      t.timestamps
    end
    add_foreign_key :likes, :users, column: :liker_id
    add_foreign_key :likes, :posts, column: :liked_post_id
  end
end
