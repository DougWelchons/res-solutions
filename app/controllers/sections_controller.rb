class SectionsController < ApplicationController
  before_action :current_user

  def show
    @section = Section.find(params[:id])
  end
end
