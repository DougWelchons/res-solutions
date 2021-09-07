class PartsController < ApplicationController

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
end
