require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'relationships' do
    it { should have_many(:additional_documents) }
    it { should have_many(:interviews) }
    it { should have_many(:interview_questions) }
    it { should have_many(:field_interviews) }
    it { should have_many(:field_interview_questions) }
  end
end
