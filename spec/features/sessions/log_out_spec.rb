require 'rails_helper'

feature 'User can log out',  %q{
  In order to end session
  As an authenticated user
  I'd like to sign out
} do

  given(:user) {create(:user)}

  scenario 'Authenticated ser signs out' do
    sign_in(user)
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'

  end
end
