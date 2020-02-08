require 'rails_helper'
feature 'User can destroy certain answer', %q{
  In order to delete  answers from database
  As an authenticated
  I'd like to delete my answer
} do
    given!(:users) {create_list(:user, 2)}
    given!(:question) {create(:question)}
    given!(:answer) {create(:answer, question: question, author: users[0])}


    describe 'Authenticated user' do
      scenario 'who is an author of question tries to delete question' do
        sign_in(answer.author)
        visit question_path(answer.question)
        click_on 'Delete answer'

        expect(page).to have_content 'Your answer successfully deleted.'
        expect(page).to_not have_content answer.body

      end

      scenario 'who is NOT an author of question' do
        sign_in(users[1])
        visit question_path(answer.question)
        expect(page).to_not have_link 'Delete answer'
      end
    end
    describe 'Unauthenticated user' do
      scenario 'tries to delete question' do
        visit question_path(answer.question)
        expect(page).to_not have_link 'Delete answer'
      end
    end
  end
