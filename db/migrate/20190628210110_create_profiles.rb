class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :gravatar_digest
      t.datetime :birth_date
      t.string :gender
      t.string :country
      t.string :state
      t.string :city
      t.string :phone_number
      
      t.timestamps
    end

  end
end
