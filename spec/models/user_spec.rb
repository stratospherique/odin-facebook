require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a first name, last name, email and password" do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
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

  it "is invalid when the email format is wrong" do
    user = User.new(email: "aldoqsd1")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end

  it "is invalid when email is taken" do
    User.create(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    user = User.new(
      first_name: "Maxim",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    user.valid? 
    expect(user.errors[:email]).to include("has already been taken")
  end
    
  it "is invalid without a email adress" do 
    user = User.new(email: "")
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password"do
    user = User.new(password: "")
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a short password"do
    user = User.new(password: "41256")
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
  end

  it "is invalid without a password confirmation" do
    user = User.new(
      first_name: "Maxim",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password"
    )
    user.valid? 
    expect(user.errors[:password_confirmation]).to include("can't be blank")
  end
  
  it "is invalid without a matching password confirmation" do
    user = User.new(
      first_name: "Maxim",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "npassword"
    )
    user.valid? 
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end

  it "returns an user's full name as a string" do
    user = User.new(
      first_name: "Maxim",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    expect(user.name).to eq "Maxim fernando"
  end
  
end
