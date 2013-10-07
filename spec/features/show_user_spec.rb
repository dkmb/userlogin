require 'spec_helper'

describe "Viewing an individual user" do

  it "shows the user's details" do
    user = User.create(user_attributes(username: "Tom", password: "1234", email: "tom@stuff.com"))

    visit user_url(user)

    expect(page).to have_text(user.username)
    expect(page).to have_text(user.password)
    expect(page).to have_text(user.email)
  end

end