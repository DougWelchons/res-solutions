require 'rails_helper'

RSpec.describe SubSection, type: :model do
  describe "relationships" do
    it { should belong_to(:section) }
    it { should have_one(:report).through(:section) }
    it { should have_many(:parts) }
    it { should have_many(:related_pt1s).through(:parts) }
    it { should have_many(:related_pt2s).through(:parts) }
    it { should have_many(:related_pt3s).through(:parts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:section_number) }
  end

  describe "Instance Methods" do
    it "automatically creates report parts"
  end
end
