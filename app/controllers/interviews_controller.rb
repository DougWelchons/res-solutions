class InterviewsController < ApplicationController
  before_action :current_user

  def new
  end

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
