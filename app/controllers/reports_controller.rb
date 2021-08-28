class ReportsController < ApplicationController

  def index
    @reports = {open: Report.open, closed: Report.closed}
  end

  def show
    @report = Report.find(params[:id])
  end
end
