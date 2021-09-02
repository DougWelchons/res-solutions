class Part < ApplicationRecord
  has_one :user
  belongs_to :sub_section
  has_one :section, through: :sub_section
  has_one :report, through: :section
  has_one :related_pt1, class_name: 'RelatedPart', foreign_key: 'pt1_id'
  has_one :related_pt2, class_name: 'RelatedPart', foreign_key: 'pt2_id'
  has_one :related_pt3, class_name: 'RelatedPart', foreign_key: 'pt3_id'

  validates :section_number, presence: true, uniqueness: { scope: :sub_section_id }

  def self.build(part_hash, subsection)
    build_parts(part_hash[:p100], subsection, "100")
    build_parts(part_hash[:p101], subsection, "101")
    build_parts(part_hash[:p102], subsection, "102")
  end

  def self.build_parts(build_map, subsection, code)
    counter = 1

    while counter <= build_map[:pt1] do
      part = Part.create!(section_number: "#{code}.#{subsection.section_number}.#{counter}", sub_section: subsection)
      RelatedPart.create!(pt1_id: part.id)
      counter += 1
    end

    build_map[:pt2].each do |p|
      part = Part.create!(section_number: "#{code}.#{subsection.section_number}.#{counter}", sub_section: subsection)
      if p.nil?
        RelatedPart.create!(pt2_id: part.id)
      else
        pt1 = subsection.parts.find_by(section_number: "#{code}.#{subsection.section_number}.#{p}")
        rp = RelatedPart.find_by(pt1_id: pt1.id)
        rp.update!(pt2_id: part.id)
      end
      counter += 1
    end

    build_map[:pt3].each do |p|
      part = Part.create!(section_number: "#{code}.#{subsection.section_number}.#{counter}", sub_section: subsection)
      if p.nil?
        RelatedPart.create!(pt3_id: part.id)
      else
        pt1 = subsection.parts.find_by(section_number: "#{code}.#{subsection.section_number}.#{p}")
        rp = RelatedPart.where(pt1_id: pt1.id).or(RelatedPart.where(pt2_id: pt1.id)).first
        rp.update!(pt3_id: part.id)
      end
      counter += 1
    end

    if subsection.section_number == "100.2.3.3"
      part1 = Part.create!(section_number: "101.2.3.1", sub_section: subsection)
      part2 = Part.create!(section_number: "101.2.3.2", sub_section: subsection)
      pt1 = subsection.parts.find_by(section_number: "100.2.3.3")
      rp = RelatedPart.find_by(pt1_id: pt1.id)
      rp.update!(pt2_id: part1.id, pt3_id: part2.id)
    end
  end
end
