class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :message
      t.integer :user_id
      t.timestamps
    end

    add_foreign_key :notifications,:users
  end
end
