class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :body
      t.integer :commenter_id
      t.integer :post_id
      


      t.timestamps
    end
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :users, column: :commenter_id
  end
end
