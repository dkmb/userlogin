require 'spec_helper'

describe "Viewing the list of users" do

  it "shows the users stored in the database" do
    userA = User.create(username: "Bob",
                              password: "abcd",
                              email: "bob@stuff.com")

    userB = User.create(username: "Tom",
                              password: "p@ssw0rd",
                              email: "tom@stuff.com")

    userC = User.create(username: "Richard",
                              password: "1234",
                              email: "richard@stuff.com")

    visit users_url

    expect(page).to have_text(userA.username)
    expect(page).to have_text(userB.username)
    expect(page).to have_text(userC.username)

    expect(page).to have_text("bob@stuff.com")
    expect(page).to have_text("tom@stuff.com")
    expect(page).to have_text("richard@stuff.com")
  end

end
