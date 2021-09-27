class User < ApplicationRecord
  has_many :parts
  has_many :additional_documents
  has_many :interview_questions
  has_many :interviews
  has_many :field_interview_questions
  has_many :field_interviews
end
