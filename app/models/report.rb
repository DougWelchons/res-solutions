class Report < ApplicationRecord

  validates :name, presence: true, uniqueness:true
  validates :company, presence: true

  enum status: [:open, :closed]
end
