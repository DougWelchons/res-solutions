class AdditionalDocumentsController < ApplicationController
  before_action :current_user

  def new
    @part = Part.find(params[:part_id])
  end

  def create
    add_doc = @user.additional_documents.new(add_docs_params)

    if add_doc.save!
      redirect_to section_path(add_doc.section)
    else
      redirect_to new_part_additional_document_path(params[:part_id])
    end
  end

  private

  def add_docs_params
    params.permit(:document, :notes, :part_id)
  end
end
