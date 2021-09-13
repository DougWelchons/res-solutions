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

  def edit
    @interview_question = InterviewQuestion.find(params[:id])
  end

  def update
    @interview_question = InterviewQuestion.find(params[:id])

    if @interview_question.update(interview_question_params)
      redirect_to section_path(@interview_question.section)
    else
      redirect_to edit_part_interview_question_path(@part, @interview_question)
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
