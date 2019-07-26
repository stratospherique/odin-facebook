require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'is invalid whithout a city' do 
    user = User.new(
        first_name: "jorge",
        last_name: "fernando",
        email: "jorge@gmail.com",
        password: "password",
        password_confirmation: "password"
    )
    profile = user.build_profile(city: "")
    profile.valid?
    expect(profile.errors[:city]).to include("can't be blank")
  end
  it 'is invalid whithout a gender' do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
  )
  profile = user.build_profile(gender: "")
  profile.valid?
  expect(profile.errors[:gender]).to include("can't be blank")
  end
  it 'is invalid whithout a birthday' do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
  )
  profile = user.build_profile(birth_date: "")
  profile.valid?
  expect(profile.errors[:birth_date]).to include("can't be blank")
  end
  it 'is invalid whithout a phone number' do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
  )
  profile = user.build_profile(phone_number: "")
  profile.valid?
  expect(profile.errors[:phone_number]).to include("can't be blank")
  end

  it 'is invalid whithout a valid phone number' do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
  )
  profile = user.build_profile(phone_number: "azeqsfqs")
  profile.valid?
  expect(profile.errors[:phone_number]).to include("is invalid")
  end

  it 'is invalid whithout a state' do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
  )
  profile = user.build_profile(state: "")
  profile.valid?
  expect(profile.errors[:state]).to include("can't be blank")
  end

end
