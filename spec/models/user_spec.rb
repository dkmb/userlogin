require 'spec_helper'

describe "A project" do
  
  it "requires a username" do
    user = User.new(username: "")

    expect(user.valid?).to be_false
    expect(user.errors[:username].any?).to be_true
  end
  
  it "requires a password" do
    user = User.new(password: "")

    expect(user.valid?).to be_false
    expect(user.errors[:password].any?).to be_true
  end
  
  it "requires a email" do
    user = User.new(email: "")

    expect(user.valid?).to be_false
    expect(user.errors[:email].any?).to be_true
  end
  
end