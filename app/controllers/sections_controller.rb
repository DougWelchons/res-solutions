class SectionsController < ApplicationController
  before_action :current_user

  def show
    @section = Section.find(params[:id])
    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete},
      reports: {title: "Home", path: reports_path, method: :get},
      report: {title: "Report", path: report_path(@section.report), method: :get}
    }
  end
end
