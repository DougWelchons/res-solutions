class SubSection < ApplicationRecord
  belongs_to :section
  has_one :report, through: :section
  has_many :parts

  validates :name, presence: true, uniqueness: { scope: :section_id }
  validates :section_number, presence: true, uniqueness: { scope: :section_id }

  def self.build(subsection_hash, section)
    subsection = SubSection.create!(section_number: subsection_hash[:number], name: subsection_hash[:name], section: section)

    Part.build(subsection_hash[:parts], subsection)
    # subsection_hash[:parts].each do |part|
    #   Part.build(part, subsection)
    # end
  end
end
