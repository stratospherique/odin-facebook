class AddForeignKeyToProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :user_id, :integer
    add_foreign_key :profiles,:users
  end
end
