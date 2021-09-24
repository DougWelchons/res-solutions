class SectionsController < ApplicationController
  before_action :current_user

  def show
    @section = Section.where(id: params[:id]).includes(sub_sections: [
      related_pt1s: {
        pt1: [:additional_documents, :interview_questions],
        pt2: [:additional_documents, :interview_questions],
        pt3: [:additional_documents, :interview_questions]
      },
      related_pt2s: {
        pt1: [:additional_documents, :interview_questions],
        pt2: [:additional_documents, :interview_questions],
        pt3: [:additional_documents, :interview_questions]
      },
      related_pt3s: {
        pt1: [:additional_documents, :interview_questions],
        pt2: [:additional_documents, :interview_questions],
        pt3: [:additional_documents, :interview_questions]
      }
    ]).first

    @nav_bar = {
      logout: {title: "Logout", path: logout_path, method: :delete},
      reports: {title: "Home", path: reports_path, method: :get},
      report: {title: "Report", path: report_path(@section.report), method: :get}
    }
  end
end
