require 'rails_helper'
feature 'User can create an answer', %q{
  In order to help author
  As an authenticated user
  I'd like to be able to answer to question
} do
  given(:user) {create(:user)}
  given!(:question) {create(:question)}
describe 'Authenticated user' do
  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'asks a question' do
    fill_in 'Body', with: 'Test answer'
    click_on 'Add answer'

    expect(page).to have_content 'Your answer successfully created.'
    expect(page).to have_content 'Test answer'

  end

  scenario 'asks a question with errors' do
    click_on 'Add answer'
    expect(page).to have_content "Body can't be blank"
  end
end


  scenario 'Unathenticated user asks a question' do
    visit question_path(question)
    expect(page).to_not have_content 'Add answer.'
  end


end
