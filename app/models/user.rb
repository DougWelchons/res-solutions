class User < ApplicationRecord
  has_many :parts
  has_many :additional_documents
  has_many :interview_questions
  has_many :interviews
  has_many :field_interview_questions
  has_many :field_interviews

  validates :name, presence: { require: true }
  # validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, confirmation: true
  before_save {email.try(:downcase)}

  has_secure_password
end
