class ReportsController < ApplicationController
  before_action :current_user

  def index
    @reports = {open: Report.not_closed, closed: Report.closed}
    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete}
    }
  end

  def show
    @report = Report.find(params[:id])
    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete},
      reports: {title: "Home", path: reports_path, method: :get}
    }
  end
end
