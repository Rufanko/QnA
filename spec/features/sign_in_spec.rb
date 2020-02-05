require 'rails_helper'

feature 'User can sign in',  %q{
  In order to ask questions
  As an unauthenticated user
  I'd like to able to sign in
} do
  scenario 'Registered user tries to sign in' do
    User.create!(email: 'asd@test.com', password: '1234567')

    visit new_user_session_path
    fill_in 'Email',  with: 'asd@test.com'
    fill_in 'Password', with: '1234567'

    expect(page).to have_content 'Signed in succesfully.'
  end

  scenario 'Unregistered user tries to sign in'
end
