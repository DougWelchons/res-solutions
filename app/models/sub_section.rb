class SubSection < ApplicationRecord
  belongs_to :section
  has_one :report, through: :section
  has_many :parts
  has_many :related_pt1s, through: :parts
  has_many :related_pt2s, through: :parts
  has_many :related_pt3s, through: :parts
  has_many :additional_documents, through: :parts
  has_many :interview_questions, through: :parts
  has_many :field_interview_questions, through: :parts

  validates :name, presence: true, uniqueness: { scope: :section_id }
  validates :section_number, presence: true, uniqueness: { scope: :section_id }
end
