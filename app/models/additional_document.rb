class AdditionalDocument < ApplicationRecord
  belongs_to :user
  belongs_to :part
  has_one :sub_section, through: :part
  has_one :section, through: :sub_section
  has_one :report, through: :section

  validates :document, presence: true
end
