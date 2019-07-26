require 'rails_helper'

RSpec.describe Comment, type: :model do
  it "should be invalid without a body" do
    comment = Comment.new(body: nil)
    comment.valid?    
    expect(comment.errors[:body]).to include("can't be blank")
  end
  it "should be invalid without a commenter" do
    comment = Comment.new(body: "This is a test body")
    comment.valid?
    expect(comment.errors[:commenter]).to include("must exist")
  end

  it "should be invalid without a post" do
    comment = Comment.new(body: "This is a test body")
    comment.valid?
    expect(comment.errors[:post]).to include("must exist")
  end

  it "should return the commenter full name" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    post = Post.create(
      title: "Test title"
    )

    comment = Comment.new(body: "This is a test body", commenter: user)
    expect(comment.commenter.name).to eq "jorge fernando"
  end

  it "should return the title and the body  of the post the comment was made" do
    user = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password",
    )

    post = Post.create(
      title: "Test title",
      body: "This is the post's body"
    )

    comment = Comment.new(body: "This is a test body", commenter: user, post: post)
    expect(comment.post.body).to eq "This is the post's body"
    expect(comment.post.title).to eq "Test title"
    
  end


end
