require 'rails_helper'
feature 'User can view list of questions', %q{
  In order to find my questions and get answer
  As an authenticated ur unauthenticated user
  I'd like to be able to view list of all questions
} do

  given!(:questions) {create_list(:question, 3)}
  given(:user) {create(:user)}

  scenario 'Authenticated user tries to watch list of questions' do
    sign_in(user)
    visit questions_path

    expect(page).to have_content 'Questions'
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end

  scenario 'Unauthenticated user tries to watch list of questions' do
    visit questions_path

    expect(page).to have_content 'Questions'
    questions.each do |question|
      expect(page).to have_content question.title
      expect(page).to have_content question.body
    end
  end
end
