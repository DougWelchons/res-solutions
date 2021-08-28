class ReportsController < ApplicationController

  def index
    @reports = {open: Report.open, closed: Report.closed}
  end

  def show
  end
end
