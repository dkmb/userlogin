require 'spec_helper'

describe "Deleting a user" do
  it "destroys the user and shows the user listing" do
    user = User.create(user_attributes)

    visit user_path(user)

    click_link 'Delete'

    expect(current_path).to eq(users_path)
    expect(page).not_to have_text(user.username)
    expect(page).to have_text('Account successfully deleted!')
  end
end