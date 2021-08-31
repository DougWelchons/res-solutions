class SubSection < ApplicationRecord
  belongs_to :section
  has_one :report, through: :section
  has_many :parts

  validates :name, presence: true, uniqueness: { scope: :section_id }
  validates :section_number, presence: true, uniqueness: { scope: :section_id }
end
