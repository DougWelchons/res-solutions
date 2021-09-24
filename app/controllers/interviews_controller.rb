class InterviewsController < ApplicationController
  before_action :current_user

  def index
    if params[:report_id]
      report = Report.find(params[:report_id])
      @interviews = report.interviews
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get},
        report: {title: "Report", path: report_path(report), method: :get}
      }
    elsif params[:section_id]
      section = Section.find(params[:section_id])
      @interviews = section.interviews
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get},
        report: {title: "Report", path: report_path(section.report), method: :get},
        section: {title: "Section", path: section_path(section), method: :get},
      }
    else
      @interviews = Interview.all
      @nav_bar = {
        logout: {title: "Logout", path: logout_path, method: :delete},
        reports: {title: "Home", path: reports_path, method: :get}
      }
    end
  end

  def show
    @interview = Interview.find(params[:id])
    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete},
      reports: {title: "Home", path: reports_path, method: :get},
      report: {title: "Report", path: report_path(@interview.report), method: :get},
      section: {title: "Section", path: section_path(@interview.section), method: :get},
    }
  end

  def new; end

  def create
    interview = @user.interviews.new(interview_params)

    if interview.save
      redirect_to report_path(interview.report)
    else
      redirect_to section_interviews_path(params[:section_id])
    end
  end

  def edit
    @interview = Interview.find(params[:id])
  end

  def update
    @interview = Interview.find(params[:id])

    if @interview.update(interview_params)
      redirect_to report_path(@interview.report)
    else
      redirect_to section_interview_path(@section, @interview)
    end
  end

  private

  def interview_params
    params.permit(:date, :time, :stakeholder, :attendees, :background, :interview, :report_summery, :section_id)
  end
end
