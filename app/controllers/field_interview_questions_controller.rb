class FieldInterviewQuestionsController < ApplicationController
  before_action :current_user
  before_action :find_part, only: [:new, :create, :edit, :update]

  def index
    if params[:report_id]
      report = Report.find(params[:report_id])
      @field_interview_questions = report.field_interview_questions
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get},
        report: {title: "Report", path: report_path(report), method: :get}
      }
    else
      @field_interview_questions = FieldInterviewQuestion.all
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get}
      }
    end
  end

  def new
    @part = Part.find(params[:part_id])
  end

  def create
    field_interview_question = @user.field_interview_questions.new(field_interview_question_params)

    if field_interview_question.save
      redirect_to section_path(field_interview_question.section)
    else
      redirect_to new_part_field_interview_question_path(@part)
    end
  end

  def edit
    @field_interview_question = FieldInterviewQuestion.find(params[:id])
  end

  def update
    @field_interview_question = FieldInterviewQuestion.find(params[:id])

    if @field_interview_question.update(field_interview_question_params)
      redirect_to section_path(@field_interview_question.section)
    else
      redirect_to edit_part_field_interview_question_path(@part, @field_interview_question)
    end
  end

  private

  def field_interview_question_params
    params.permit(:question, :notes, :part_id)
  end

  def find_part
    @part = Part.find(params[:part_id])
  end
end
