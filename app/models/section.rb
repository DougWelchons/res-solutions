class Section < ApplicationRecord
  belongs_to :report
  has_many :sub_sections
  has_many :parts, through: :sub_sections

  validates :name, presence: true, uniqueness: { scope: :report_id }
end
