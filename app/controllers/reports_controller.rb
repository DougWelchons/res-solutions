class ReportsController < ApplicationController

  def index
    @reports = {open: Report.not_closed, closed: Report.closed}
  end

  def show
    @report = Report.find(params[:id])
  end
end
