class Report < ApplicationRecord
  has_many :sections
  has_many :sub_sections, through: :sections
  has_many :parts, through: :sub_sections
  has_many :related_pt1s, through: :parts
  has_many :related_pt2s, through: :parts
  has_many :related_pt3s, through: :parts
  has_many :additional_documents, through: :parts
  has_many :interviews, through: :sections
  has_many :interview_questions, through: :parts
  has_many :field_interviews, through: :sections
  has_many :field_interview_questions, through: :parts

  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:prep, :kick_off, :document_review, :field_review, :reporting, :closed]


  # def self.all_by_status
  # {"Prep" => Report.prep, "Kick off" => Report.kick_off, "Document review" => Report.document_review, "Field review" => Report.field_review, "Reporting" => Report.reporting, "Closed" => Report.closed}
  # end
end
