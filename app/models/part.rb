class Part < ApplicationRecord
  has_one :user
  belongs_to :sub_section
  has_many :additional_documents
  has_many :interview_questions
  has_one :section, through: :sub_section
  has_one :report, through: :section
  has_one :related_pt1, class_name: 'RelatedPart', foreign_key: 'pt1_id'
  has_one :related_pt2, class_name: 'RelatedPart', foreign_key: 'pt2_id'
  has_one :related_pt3, class_name: 'RelatedPart', foreign_key: 'pt3_id'

  validates :section_number, presence: true, uniqueness: { scope: :sub_section_id }
end
