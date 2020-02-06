require 'rails_helper'

feature 'User can sign up',  %q{
  In order to ask question
  As an unauthenticated user
  I'd like to able to sign in
} do


  background { visit new_user_registration_path}

  scenario 'User tries to sign up with valid email and password' do
    fill_in 'Email',  with: 'zxc@test.com'
    fill_in 'Password', with: '12345678'
    fill_in 'Password confirmation', with: '12345678'

    click_button 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'User tries to register with existing email' do
    User.create!(email: 'asd@test.com', password: '12345679')

    fill_in 'Email',  with: 'asd@test.com'
    fill_in 'Password', with: '12345679'
    click_button 'Sign up'
    expect(page).to have_content 'Email has already been taken'

  end

  scenario 'User tries to register with invalid password' do
    fill_in 'Email',  with: 'yyy@test.com'
    fill_in 'Password', with: '12'
    click_button 'Sign up'
    expect(page).to have_content 'Password is too short (minimum is 6 characters)'
  end

end
