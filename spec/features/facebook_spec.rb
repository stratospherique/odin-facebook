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

  context "Uniking a post on the profile view" do
    scenario "unliking a post" do
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
      expect{
        first(:link, "unlike").click
      }.to change(Like.all, :size).by(-1)
      expect(page).to have_current_path user_path(user)    
    end
    
  end

  context "inviting people you might know to become friends" do
    scenario "Do the invite of a person" do
      u1 = User.create(
        first_name: "jorge",
        last_name: "fernando",
        email: "jorge@gmail.com",
        password: "password",
        password_confirmation: "password"
        )
      u2 = User.create(
          first_name: "fernando",
          last_name: "jorge",
          email: "jorgen@gmail.com",
          password: "password",
          password_confirmation: "password"
        )
        visit root_path
        fill_in "user_email", with: "jorge@gmail.com"
        fill_in "user_password", with: "password"
        click_on "Log in"  
        visit users_path
        expect{
          click_on "Invite the fool!"
        }.to change(u1.invitations.where(status: "pending"), :size).by(1)
      end
      scenario "removing the pending friend request" do 
        u1 = User.create(
          first_name: "jorge",
          last_name: "fernando",
          email: "jorge@gmail.com",
          password: "password",
          password_confirmation: "password"
          )
        u2 = User.create(
            first_name: "fernando",
            last_name: "jorge",
            email: "jorgen@gmail.com",
            password: "password",
            password_confirmation: "password"
          )
          visit root_path
          fill_in "user_email", with: "jorge@gmail.com"
          fill_in "user_password", with: "password"
          click_on "Log in"  
          visit users_path
          expect{
            click_on "Invite the fool!"
          }.to change(u1.invitations.where(status: "pending"), :size).by(1)
          expect{
            click_on "Delete Friend Request"
          }.to change(u1.invitations.where(status: "pending"), :size).by(-1)
        end
    end

    context "Accept a friend request"do
      

      scenario "Accept the friend request received" do
        u1 = User.create(
          first_name: "jorge",
          last_name: "fernando",
          email: "jorge@gmail.com",
          password: "password",
          password_confirmation: "password"
          )
        u2 = User.create(
            first_name: "fernando",
            last_name: "jorge",
            email: "jorgen@gmail.com",
            password: "password",
            password_confirmation: "password"
          )
          visit root_path
          fill_in "user_email", with: "jorge@gmail.com"
          fill_in "user_password", with: "password"
          click_on "Log in"  
          visit users_path
          expect{
            click_on "Invite the fool!"
          }.to change(u1.invitations.where(status: "pending"), :size).by(1)
          click_on "Logout"
          fill_in "user_email", with: "jorgen@gmail.com"
          fill_in "user_password", with: "password"
          click_on "Log in"
          visit users_path
          expect{
            click_link "accept friendship"
          }.to change(u1.invitations.where(status: "accepted"), :size).by(1)
          
      end


    end


    context "testing header navigation link" do
      scenario "navigate to the timeline view" do
        u1 = User.create(
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
        click_on 'Home'
        expect(page).to have_current_path posts_path
      end

      scenario "navigate to the profile view" do
        u1 = User.create(
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
        click_on 'Profile'
        expect(page).to have_current_path user_path(u1)
      end

      scenario "navigate to the friend requests view" do
        u1 = User.create(
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
        click_on 'Friend Requests (0)'
        expect(page).to have_current_path users_path
      end

      scenario "check the presence of an avatar dropdown menu" do
        u1 = User.create(
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
        click_on 'Notifications'
        expect(page).to have_current_path notifications_index_path
        expect(page).to have_css("img",:count => 1)
        expect(page).to have_css(".drop-btn")
      end
      
    end

    before do
      Rails.application.env_config["devise.mapping"] = Devise.mappings[:user] # If using Devise
      Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
    end

   
  
end
