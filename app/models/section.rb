class Section < ApplicationRecord
  belongs_to :report
  has_many :sub_sections
  has_many :parts, through: :sub_sections
  # has_many :related_parts, through: :parts
  has_many :related_pt1s, through: :parts
  has_many :related_pt2s, through: :parts
  has_many :related_pt3s, through: :parts

  validates :name, presence: true, uniqueness: { scope: :report_id }

  def self.build(section_hash, report_id)
    section = Section.create!(name: section_hash[:section_name], report_id: report_id)

    section_hash[:sub_sections].each do |subsection|
      SubSection.build(subsection, section)
    end
  end
end
