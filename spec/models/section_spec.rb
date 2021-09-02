require 'rails_helper'

RSpec.describe Section, type: :model do
  describe "relationships" do
    it { should belong_to(:report) }
    it { should have_many(:sub_sections) }
    it { should have_many(:parts).through(:sub_sections) }
    # it { should have_many(:related_parts).through(:parts) }
    it { should have_many(:related_pt1s).through(:parts) }
    it { should have_many(:related_pt2s).through(:parts) }
    it { should have_many(:related_pt3s).through(:parts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    # it { should validate_uniqueness_of(:name).scoped_to(:report) }
    # it { should validate_uniqueness_of(:name).case_insensitive }
  end

  describe "Instance Methods" do
    it "automatically creates report sub-sections"
  end
end
