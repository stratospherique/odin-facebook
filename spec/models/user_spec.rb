require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last name, email and password" do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password"
    )
    expect(user).to be_valid
  end
  
  it "is invalid without a first name" do
    user = User.new(first_name: nil)
    user.valid?
    expect(user.errors[:first_name]).to include("can't be blank")
  end

  it "is invalid with a first name with less than 4 characters" do
    user = User.new(first_name: "aaa")
    user.valid?
    expect(user.errors[:first_name]).to include("is too short (minimum is 4 characters)")
  end

  it "is invalid with a first name that has more than 20" do
    user = User.new(first_name: "a" * 21)
    user.valid?
    expect(user.errors[:first_name]).to include("is too long (maximum is 20 characters)")
  end

  it "is invalid without a last name" do
    user = User.new(last_name: nil)
    user.valid?
    expect(user.errors[:last_name]).to include("can't be blank")
  end

  it "is invalid with a last name with less than 4 characters" do
    user = User.new(last_name: "aaa")
    user.valid?
    expect(user.errors[:last_name]).to include("is too short (minimum is 4 characters)")
  end

  it "is invalid with a last name that has more than 20" do
    user = User.new(last_name: "a" * 21)
    user.valid?
    expect(user.errors[:last_name]).to include("is too long (maximum is 20 characters)")
  end

  it "is invalid without a email adress" 
  it "is invalid without a password"
  it "is invalid without a matching password confirmation"
  it "is invalid with a duplicate email adress"
end
