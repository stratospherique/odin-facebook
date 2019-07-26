require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it "makes the invitation status pending automatically" do
    request = Invitation.new
    expect(request.status).to match(/^pending$/)
  end
  it "is invalid without an invitee user" do
    u2 = User.create(
      first_name: "ahmed",
      last_name:"mahfoudh",
      email:"ahmed@gmail.com",
      password: "password",
      password_confirmation: "password",
    )
    request = Invitation.new(invited: u2)
    request.valid?
    expect(request.errors[:invitee]).to include("must exist")
  end
  it "is invalid without an invited user" do
    u1 = User.create(
      first_name: "jorge",
      last_name:"fernando",
      email:"jorge@gmail.com",
      password: "password",
      password_confirmation: "password"
    )
    
    request = Invitation.new(invitee: u1)
    request.valid?
    expect(request.errors[:invited]).to include("must exist")
  end
end
