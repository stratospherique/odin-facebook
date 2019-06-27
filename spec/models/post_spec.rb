require 'rails_helper'

RSpec.describe Post, type: :model do
  it"should ve valid with a title, body and author" do
    @user = User.new(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    post = Post.new(
      title: "Test Title",
      body: "Test Body",  
      author: @user     
      )
    expect(post).to be_valid
  end

  it "should not allow duplicate post names per user" do
    user = User.new(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    user.save
    
    user.posts.create(
      title:"Test Title",
      body: "test body"
    )

    post = user.posts.build(
      title:"Test Title",
      body: "test body"
    )
    
    post.valid?
    expect(post.errors[:title]).to include("has already been taken")
  end

end
