require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let (:question) {create (:question) }

  describe 'GET #new' do
    before {get :new, params: {question_id: question} }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq(question)
    end

    it 'assigns a new  Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders correct view' do
      expect(response).to render_template :new
    end

  end

  describe 'GET #show' do

    let (:answer) { create(:answer, question: question) }

    before  { get :show, params: {id: answer} }

    it 'assigns the requested answer to @answer' do
      expect(assigns(:answer)).to eq answer
    end

    it 'renders show view' do
      expect(response).to render_template :show
    end
  end

  describe ' POST #create' do
    context 'with valid attributes' do

      it 'assigns the requested question to @question' do
        post :create,  params: { answer: attributes_for(:answer), question_id: question }
        expect(assigns(:question)).to eq(question)
      end

      it 'saves a new answer in the database' do
        expect {post :create, params: { answer: attributes_for(:answer), question_id: question } }.to change(question.answers, :count).by(1)
      end

      it 'redirects to show view' do
        post :create,  params: { answer: attributes_for(:answer), question_id: question }
        expect(response).to redirect_to assigns(:answer)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect {post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question } }.to_not change(question.answers, :count)
      end

      it 're-renders new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question }
        expect(response).to render_template :new
      end
    end
  end

end
