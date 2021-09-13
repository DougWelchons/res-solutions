require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:additional_documents) }
  it { should have_many(:interview_questions) }
end
