require 'rails_helper'

RSpec.describe Like, type: :model do
  it "can only allow one like per user in a comment" do
    user = User.new(
      first_name: "jorge",
      last_name: "fernando",
      email: "jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    user.save
    
    p = user.posts.build(
      title:"Test Title",
      body: "test body"
    )

    p.save


    Like.create(liker_id: user.id, liked_post_id: p.id)
    l1 = Like.new(liker_id: user.id, liked_post_id: p.id)
    l1.valid?   
    expect(l1.errors[:liker_id]).to include("has already been taken")
  end

  it "is invalid without a liker" do
    l1 = Like.new(liker_id: nil, liked_post_id: 22)
    l1.valid?   
    expect(l1.errors[:liker]).to include("must exist")
  end

  it "is invalid without a liker" do
    l1 = Like.new(liker_id: nil, liked_post_id: 22)
    l1.valid?   
    expect(l1.errors[:liker]).to include("must exist")
  end

  it "is invalid without a post" do
    l1 = Like.new(liker_id: 1, liked_post_id: nil)
    l1.valid?   
    expect(l1.errors[:liked_post]).to include("must exist")
  end

end
