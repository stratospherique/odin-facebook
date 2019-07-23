require 'rails_helper'

RSpec.feature "Facebooks", type: :feature do
  scenario "creation of a new user" do
    visit root_path
    click_link "Sign up"
  end
end
