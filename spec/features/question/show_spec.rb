require 'rails_helper'
feature 'User can view certain question', %q{
  In order to watch a question and answers to this questions
  As an authenticated ur unauthenticated user
  I'd like to be able to view question and its answers
} do

    given!(:question) {create(:question)}
    given(:user) {create(:user)}
    given!(:answers) {create_list(:answer, 4, question: question)}

    scenario 'Authenticated user tries to watch question' do
      sign_in(user)
      visit question_path(question)

      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_content 'All answers to this question'
      answers.each {|answer| expect(page).to have_content answer.body }
      expect(page).to have_content 'Add answer to this question'
      expect(page).to have_field 'Body'

    end

    scenario 'Unauthenticated user tries to watch list of questions' do
      visit question_path(question)
      expect(page).to have_content question.title
      expect(page).to have_content question.body
      expect(page).to have_content 'All answers to this question'
      answers.each {|answer| expect(page).to have_content answer.body }
      #expect(page).to_not have_content 'Add answer to this question'
      #expect(page).to_not have_field 'Body'
    end
  end
