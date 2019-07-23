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
end
