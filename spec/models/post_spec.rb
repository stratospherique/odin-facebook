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

  it "is invalid without a title" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    
    
    post = user.posts.new(
      body: "test body"
    ) 
    post.valid? 
    expect(post.errors[:title]).to include("can't be blank")
  end

  it "is invalid without a body" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    
    
    post = user.posts.new(
      title: "test title"
    ) 
    post.valid? 
    expect(post.errors[:body]).to include("can't be blank")
  end

  it "displays the right author of the post" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    
    
    post = user.posts.create(
      title: "test title",
      body: "this is a body",
    ) 
    
    expect(post.author).to eq user
  end

  it "displays the right author name of the post"  do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    
    
    post = user.posts.create(
      title: "test title",
      body: "this is a body",
    ) 
    
    expect(post.author.name).to eq user.name
  end

  it "displays an empty posts' list if the user hasn't created a post" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )
    expect(user.posts).to be_empty
  end
end
