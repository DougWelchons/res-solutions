class InterviewQuestionsController < ApplicationController
  before_action :current_user
  before_action :find_part, only: [:new, :create, :edit, :update]

  def new
    @part = Part.find(params[:part_id])
  end

  def create
    interview_question = @user.interview_questions.new(interview_question_params)

    if interview_question.save
      redirect_to section_path(interview_question.section)
    else
      redirect_to new_part_interview_question_path(@part)
    end
  end

  private

  def interview_question_params
    params.permit(:question, :notes, :part_id)
  end

  def find_part
    @part = Part.find(params[:part_id])
  end
end
