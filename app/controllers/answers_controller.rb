class AnswersController < ApplicationController

  def show
    @answer = Answer.find(params[:id])
  end

  def new
    @answer = question.answers.new
  end

  def create
    @answer = current_user.authored_answers.new(answer_params)

    if @answer.save
      redirect_to @answer
    else
      render :new
    end
  end

  def destroy
    answer.destroy if current_user.author?(answer)
    redirect_to questions_path
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

  helper_method :question

end
