class Report < ApplicationRecord
  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:prep, :kick_off, :document_review, :field_review, :reporting, :closed]
end
