require 'rails_helper'

RSpec.describe Part, type: :model do
  describe "relationships" do
    it { should belong_to(:sub_section) }
    # it { should have_one(:user) }
    it { should have_one(:related_pt1) }
    it { should have_one(:related_pt2) }
    it { should have_one(:related_pt3) }
    it { should have_one(:section).through(:sub_section) }
    it { should have_one(:report).through(:section) }
    it { should have_many(:additional_documents) }
    it { should have_many(:interview_questions) }
    it { should have_many(:field_interview_questions) }
  end

  describe "validations" do
    it { should validate_presence_of(:section_number) }
  end
end
