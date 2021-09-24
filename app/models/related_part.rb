class RelatedPart < ApplicationRecord
  has_one :pt1, class_name: 'Part', primary_key: 'pt1_id', foreign_key: "id"
  has_one :pt2, class_name: 'Part', primary_key: 'pt2_id', foreign_key: "id"
  has_one :pt3, class_name: 'Part', primary_key: 'pt3_id', foreign_key: "id"
end
