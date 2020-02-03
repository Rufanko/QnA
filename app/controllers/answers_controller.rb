class AnswersController < ApplicationController

  def show; end

  def new
    @answer = question.answers.new
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to @answr
    else
      render :new
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def question
    @question ||= params[:id] ? Question.find(params[:id]) : Question.new
  end

  helper_method :question

end
