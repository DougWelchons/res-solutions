require 'rails_helper'

RSpec.describe SubSection, type: :model do
  describe "relationships" do
    it { should belong_to(:section) }
    it { should have_one(:report).through(:section) }
    it { should have_many(:parts) }
    it { should have_many(:related_pt1s).through(:parts) }
    it { should have_many(:related_pt2s).through(:parts) }
    it { should have_many(:related_pt3s).through(:parts) }
    it { should have_many(:additional_documents).through(:parts) }
    it { should have_many(:interview_questions).through(:parts) }
    it { should have_many(:field_interview_questions).through(:parts) }

  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:section_number) }
  end
end
