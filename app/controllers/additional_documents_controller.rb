class AdditionalDocumentsController < ApplicationController
  before_action :current_user
  before_action :find_part, only: [:new, :create, :edit, :update]

  def index
    if params[:report_id]
      @additional_documents = Report.find(params[:report_id]).additional_documents
    else
      @additional_documents = AdditionalDocument.all
    end
  end

  def new
  end

  def create
    additional_document = @user.additional_documents.new(additional_documents_params)

    if additional_document.save
      redirect_to section_path(additional_document.section)
    else
      redirect_to new_part_additional_document_path(@part)
    end
  end

  def edit
    @additional_document = AdditionalDocument.find(params[:id])
  end

  def update
    @additional_document = AdditionalDocument.find(params[:id])

    if @additional_document.update(additional_documents_params)
      redirect_to section_path(@additional_document.section)
    else
      redirect_to edit_part_additional_document_path(@part, @additional_document)
    end
  end

  private

  def additional_documents_params
    params.permit(:document, :notes, :part_id)
  end

  def find_part
    @part = Part.find(params[:part_id])
  end
end
