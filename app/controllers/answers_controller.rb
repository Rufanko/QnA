class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show ]
  #before_action :load_question, only: %i[create]

   def show
     @answer = Answer.find(params[:id])
   end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to question, notice: 'Your answer successfully created.'
    else
      render 'questions/show'
    end
  end

  def destroy
    if current_user.author?(answer)
      answer.destroy
      redirect_to question_path(answer.question),  notice: 'Your answer successfully deleted.'

   else
     redirect_to question_path(answer.question),  notice: 'Something went wrong...'
   end
  end


  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= params[:question_id] ? Question.find(params[:question_id]) : Question.new
  end

  def answer
    @answer ||= params[:id] ? Answer.find(params[:id]) : Answer.new
  end

  # def load_question
  #   @question = Question.find(params[:question_id])
  # end
  #
  # def load_answer
  #   @answer = Answer.find(params[:id])
  # end

  helper_method :question, :answer

end
