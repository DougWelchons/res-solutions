class User < ApplicationRecord
  has_many :parts
  has_many :additional_documents
end
