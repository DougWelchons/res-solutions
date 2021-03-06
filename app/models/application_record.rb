class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def all_related_parts
    (related_pt1s + related_pt2s + related_pt3s).uniq.sort_by{ |record| record.
      created_at}
  end
end
