class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]


  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = question.answers.new
  end

  def create
    @answer = question.answers.new(answer_params)
    @answer.author = current_user

    if @answer.save
      redirect_to @answer, notice: 'Your answer successfully created.'
    else
      render :new
    end
  end

  def destroy
    answer.destroy if current_user.author?(answer)
    redirect_to question_path(answer.question)
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


  helper_method :question, :answer

end
