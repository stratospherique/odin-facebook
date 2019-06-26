require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last name, email and password"
  it "is invalid without a first name"
  it "is invalid with a first name with less than 4 characters"
  it "is invalid with a first name that has more than 20"  
  it "is invalid without a last name"
  it "is invalid with a first name with less than 4 characters"
  it "is invalid with a first name that has more than 20"
  it "is invalid without a email adress"
  it "is invalid without a password"
  it "is invalid without a matching password confirmation"
  it "is invalid with a duplicate email adress"
end
