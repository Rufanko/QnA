require 'rails_helper'
feature 'User can destroy certain question', %q{
  In order to delete a question and answers from database
  As an authenticated
  I'd like to delete my question
} do

    given!(:question) {create(:question)}
    given(:user) {create(:user)}

    describe 'Authenticated user' do
      scenario 'who is an author of question tries to delete question' do
        sign_in(question.author)
        visit question_path(question)
        click_on 'Delete'
        expect(page).to_not have_content question.title
        expect(page).to_not have_content question.body
      end

      scenario 'who is NOT an author of question' do
        sign_in(user)
        visit question_path(question)
        expect(page).to_not have_link 'Delete'
      end
    end
    describe 'Unauthenticated user' do
      scenario 'tries to delete question' do
        visit question_path(question)
        expect(page).to_not have_link 'Delete'
      end
    end
  end
