class FieldInterviewsController < ApplicationController
  before_action :current_user

  def index
    if params[:report_id]
      report = Report.find(params[:report_id])
      @field_interviews = report.field_interviews
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get},
        report: {title: "Report", path: report_path(report), method: :get}
      }
    elsif params[:section_id]
      section = Section.find(params[:section_id])
      @field_interviews = section.field_interviews
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get},
        report: {title: "Report", path: report_path(section.report), method: :get},
        section: {title: "Section", path: section_path(section), method: :get},
      }
    else
      @field_interviews = FieldInterview.all
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get}
      }
    end
  end

  def show
    @field_interview = FieldInterview.find(params[:id])
    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete},
      reports: {title: "Home", path: reports_path, method: :get},
      report: {title: "Report", path: report_path(@field_interview.report), method: :get},
      section: {title: "Section", path: section_path(@field_interview.section), method: :get},
    }
  end

  def new; end

  def create
    field_interview = @user.field_interviews.new(field_interview_params)

    if field_interview.save
      redirect_to report_path(field_interview.report)
    else
      redirect_to section_field_interviews_path(params[:section_id])
    end
  end

  def edit
    @interview = FieldInterview.find(params[:id])
  end

  def update
    @field = FieldInterview.find(params[:id])

    if @field.update(field_interview_params)
      redirect_to report_path(@field.report)
    else
      redirect_to section_field_interview_path(@section, @interview)
    end
  end

  private

  def field_interview_params
    params.permit(:date, :time, :stakeholder, :attendees, :background, :interview, :report_summery, :section_id)
  end
end
