class Section < ApplicationRecord
  belongs_to :report
  has_many :interviews
  has_many :sub_sections
  has_many :parts, through: :sub_sections
  has_many :related_pt1s, through: :parts
  has_many :related_pt2s, through: :parts
  has_many :related_pt3s, through: :parts
  has_many :additional_documents, through: :parts
  has_many :interview_questions, through: :parts


  validates :name, presence: true, uniqueness: { scope: :report_id }
end
