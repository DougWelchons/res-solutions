class Part < ApplicationRecord
  belongs_to :user
  belongs_to :sub_section
  has_one :section, through: :sub_section
  has_one :report, through: :section

  validates :section_number, presence: true, uniqueness: { scope: :sub_section_id }
end
