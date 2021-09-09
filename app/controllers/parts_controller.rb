class PartsController < ApplicationController
  before_action :current_user
  def first_edit
    @part = Part.find(params[:id])
  end

  def first_update
    part = Part.find(params[:id])

    if part.update!(part_params_first)
      redirect_to section_path(part.section)
    else
      redirect_to final_edit_path
    end
  end

  def final_edit
    @part = Part.find(params[:id])
  end

  def final_update
    part = Part.find(params[:id])

    if part.update!(part_params_final)
      redirect_to section_path(part.section)
    else
      redirect_to final_edit_path
    end
  end

  private
  def part_params_first
    params.permit(:first_assessment)
  end

  def part_params_final
    params.permit(:final_assessment, :score)
  end

  def current_user
    @user = User.find(session[:user_id])

    if @user.nil?
      flash[:error] = "Sorry, your credentials are bad."
      redirect_to root_path
    end
  end
end
