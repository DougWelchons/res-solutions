class RelatedPart < ApplicationRecord
  has_one :pt1, class_name: 'Part', foreign_key: 'id'
  has_one :pt2, class_name: 'Part', foreign_key: 'id'
  has_one :pt3, class_name: 'Part', foreign_key: 'id'
  has_one :sub_section, through: :pt1
  has_one :sub_section, through: :pt2
  has_one :sub_section, through: :pt3
end
