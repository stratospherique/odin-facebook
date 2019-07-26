class AddForeignKeyToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :author_id, :integer
    add_foreign_key :posts, :users, column: :author_id
  end
end
