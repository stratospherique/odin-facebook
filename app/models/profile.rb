class Profile < ApplicationRecord
  belongs_to :user

  ## validations
  validates :city, presence: true
  validates :state, presence: true
  validates :country, presence: true 
  validates :gender, presence: true
  validates :birth_date, presence: true
  PHONE_FORMAT = /\+(9[976]\d|8[987530]\d|6[987]\d|5[90]\d|42\d|3[875]\d|2[98654321]\d|9[8543210]|8[6421]|6[6543210]|5[87654321]|4[987654310]|3[9643210]|2[70]|7|1)\d{1,14}/
  validates :phone_number, presence: true, format: {with: PHONE_FORMAT}
end
