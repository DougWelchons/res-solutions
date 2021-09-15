class Interview < ApplicationRecord
  belongs_to :section
  belongs_to :user
  has_one :report, through: :section
end
