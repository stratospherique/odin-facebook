require 'rails_helper'

RSpec.feature "Facebooks", type: :feature do
  scenario "creation of a new user" do
    #current_user = User.first
    visit root_path
    click_link "Sign up"
    expect(page).to have_current_path("/users/sign_up")
    expect{
      fill_in "user_first_name", with: "alexander"
      fill_in "user_last_name", with: "the great"
      fill_in "user_email", with: "foo@bar.com"
      fill_in "user_password", with: "123456"
      fill_in "user_password_confirmation", with: "123456"
      click_on "Sign up"
    }.to change(User.all, :size).by(1)
  end

  describe "Sign in process", type: feature do
    scenario "Login user" do
      User.create(
        first_name: "jorge",
        last_name: "fernando",
        email: "jorge@gmail.com",
        password: "password",
        password_confirmation: "password"
      )

      visit root_path
      fill_in "user_email", with: "jorge@gmail.com"
      fill_in "user_password", with: "password"
      click_on "Log in"
      
      expect(page).to have_content 'Signed in successsfully'
    end
  end

end
