require 'spec_helper'

describe "Creating a user" do
  it "saves the user and shows the user details" do
    visit users_url

    find('.userlogin-loginbox-list').click_link 'Register'

    expect(current_path).to eq(new_user_path)

    fill_in "Username", with: "Timuser"
    fill_in "Password", with: "4321"
    fill_in "Email", with: "tim@user.com"

    click_button 'Create User'

    expect(current_path).to eq(user_path(User.last))

    expect(page).to have_text('Account successfully created!')
  end

  it "does not save the user if it is invalid" do
    visit new_user_url

    expect {
      click_button 'Create User'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end