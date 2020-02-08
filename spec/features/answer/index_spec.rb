require 'rails_helper'
feature 'User can view list of answers', %q{
  In order to find answer to question
  As an authenticated ur unauthenticated user
  I'd like to be able to get answer
} do
  given!(:answers) {create_list(:answer, 3, question: question)}
  given!(:question) {create(:question)}
  given(:user) {create(:user)}

  scenario 'Authenticated user tries to watch list of questions' do
    sign_in(user)
    visit question_path(answers[1].question)
    
    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end

  scenario 'Unauthenticated user tries to watch list of questions' do

    visit question_path(answers[1].question)

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end
