class AdditionalDocumentsController < ApplicationController
  before_action :current_user
  before_action :find_part, only: [:new, :create, :edit, :update]

  def new
    # @part = Part.find(params[:part_id])
  end

  def create
    add_doc = @user.additional_documents.new(add_docs_params)

    if add_doc.save
      redirect_to section_path(add_doc.section)
    else
      redirect_to new_part_additional_document_path(@part)
    end
  end

  def edit
    @additional_document = AdditionalDocument.find(params[:id])
  end

  def update
    @additional_document = AdditionalDocument.find(params[:id])

    if @additional_document.update(add_docs_params)
      redirect_to section_path(@additional_document.section)
    else
      redirect_to edit_part_additional_document_path(@part, @additional_document)
    end
  end

  private

  def add_docs_params
    params.permit(:document, :notes, :part_id)
  end

  def find_part
    @part = Part.find(params[:part_id])
  end
end
