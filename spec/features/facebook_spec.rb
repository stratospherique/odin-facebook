require 'rails_helper'
require 'koala'

RSpec.feature "Facebooks", type: :feature do
  context "User sign up" do
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
  
    scenario "User creation failed because of an empty email" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path("/users/sign_up")
      expect{
        fill_in "user_first_name", with: "alexander"
        fill_in "user_last_name", with: "the great"
        fill_in "user_email", with: ""
        fill_in "user_password", with: "123456"
        fill_in "user_password_confirmation", with: "123456"
        click_on "Sign up"
      }.to change(User.all, :size).by(0)
      expect(page).to have_content "error prohibited this user from being saved"
      expect(page).to have_content "Email can't be blank"
    end

    scenario "User creation failed because of an empty password" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path("/users/sign_up")
      expect{
        fill_in "user_first_name", with: "alexander"
        fill_in "user_last_name", with: "the great"
        fill_in "user_email", with: "foo@bar.com"
        fill_in "user_password", with: ""
        fill_in "user_password_confirmation", with: ""
        click_on "Sign up"
      }.to change(User.all, :size).by(0)
      expect(page).to have_content "errors prohibited this user from being saved"
      expect(page).to have_content "Password can't be blank"
    end

    scenario "User creation failed because of an empty password confirmation" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path("/users/sign_up")
      expect{
        fill_in "user_first_name", with: "alexander"
        fill_in "user_last_name", with: "the great"
        fill_in "user_email", with: "foo@bar.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: ""
        click_on "Sign up"
      }.to change(User.all, :size).by(0)
      expect(page).to have_content "errors prohibited this user from being saved"
      expect(page).to have_content "Password confirmation can't be blank"
    end

    scenario "User creation failed because of an empty first name" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path("/users/sign_up")
      expect{
        fill_in "user_first_name", with: ""
        fill_in "user_last_name", with: "the great"
        fill_in "user_email", with: "foo@bar.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Sign up"
      }.to change(User.all, :size).by(0)
      expect(page).to have_content "errors prohibited this user from being saved"
      expect(page).to have_content "First name can't be blank"
    end

    scenario "User creation failed because of an empty last name" do
      visit root_path
      click_link "Sign up"
      expect(page).to have_current_path("/users/sign_up")
      expect{
        fill_in "user_first_name", with: "Alexander"
        fill_in "user_last_name", with: ""
        fill_in "user_email", with: "foo@bar.com"
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_on "Sign up"
      }.to change(User.all, :size).by(0)
      expect(page).to have_content "errors prohibited this user from being saved"
      expect(page).to have_content "Last name can't be blank"
    end




  end
  

  context "User Log in Tests" do
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
      
      expect(page).to have_content 'Signed in successfully'
    end

  end

  context "Post creation process On the timeline view" do
    scenario "Creating a post" do
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
    
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      }.to change(Post.all, :size).by(1)
      expect(page).to have_content "Random message to test over here"
      expect(page).to have_current_path posts_path
    end
  end

  context "Post creation process On the Profile view" do
    scenario "Creating a post" do
      user = User.create(
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
      visit user_path(user)
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      }.to change(Post.all, :size).by(1)
      expect(page).to have_content "Random message to test over here"
      expect(page).to have_current_path user_path(user)
    end
  end

  context "Commenting on a post on the timeline view" do
    scenario "commenting on a post" do
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
    
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      fill_in "body", with: "Random coment to be placed here"
      click_on "Add comment"
      }.to change(Comment.all, :size).by(1)
      expect(page).to have_content "Random coment to be placed here"
      expect(page).to have_current_path posts_path
    end
  end
  
  context "Commenting on a post on the Profile view" do
    scenario "Commenting on a post" do
      user=User.create(
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
      visit user_path(user)
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      fill_in "body", with: "Random coment to be placed here"
      click_on "Add comment"
      }.to change(Comment.all, :size).by(1)
      expect(page).to have_content "Random coment to be placed here"
      expect(page).to have_current_path user_path(user)
    end
  end

  context "Liking a post on the timeline view" do
    scenario "liking a post" do
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
    
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      click_on "Like"
      }.to change(Like.all, :size).by(1)
      expect(page).to have_link('unlike')
      expect(page).to have_current_path posts_path
    end

    scenario "unliking a post" do
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
    
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      click_on "Like"
      }.to change(Like.all, :size).by(1)
      expect{
        first(:link, "unlike").click
      }.to change(Like.all, :size).by(-1)
      expect(page).to have_current_path posts_path
    end
  end

  context "Liking a post on the profile view" do
    scenario "liking a post" do
      user = User.create(
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
      visit user_path(user)
      expect{
      fill_in "post_title", with: "Random title"
      fill_in "post_body", with: "Random message to test over here"
      click_on "Create Post"
      click_on "Like"
      }.to change(Like.all, :size).by(1)
      expect(page).to have_link('unlike')
      expect(page).to have_current_path user_path(user)
    end
  end
=begin
    context "sign in with facebook" do
      before do
        @test_users_api=Koala::Facebook::TestUsers.new(:app_id =>"721321031658977" , :secret =>"07a2196c4e9d1367ea0770f1cdb8aa5b")
        @test_user=@test_users_api.create(false)
        # creates a user who hasn't installed your app
      end
      after do
        @test_users_api.delete(@test_user["id"])
      end
      scenario "login a user with facebook" do
        visit root_path
        click_on "Sign in with Facebook"
        fill_in "email",with: @test_user["email"]
        fill_in "pass",with: @test_user["password"]
        click_on "loginbutton"
        find(:xpath, "//button[@name='__CONFIRM__']").click
        expect(page).to have_content("Successfully authenticated from Facebook account.")
      end
    end
=end
    
end
