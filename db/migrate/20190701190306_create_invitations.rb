class CreateInvitations < ActiveRecord::Migration[5.2]
  def change
    create_table :invitations do |t|
      t.integer :invitee_id
      t.integer :invited_id
      t.string :status, default: "pending"
      t.timestamps
    end

    add_foreign_key :invitations, :users, column: :invitee_id
    add_foreign_key :invitations, :users, column: :invited_id
  end
end
