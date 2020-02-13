require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validation' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end

  describe 'associations' do
    it { should have_many(:answers).dependent(:nullify)}
    it { should have_many(:questions).dependent(:nullify)}
  end

  describe '#author?' do
    let(:user) {create (:user)}
    let(:question_without_author) {create(:question)}
    let(:question) {create(:question, author: user)}
    it 'should correctly check the authorship' do
      expect(user).to be_author(question)
      expect(user).not_to be_author(question_without_author)
    end
  end




end
