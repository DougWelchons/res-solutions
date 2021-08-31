require 'rails_helper'

RSpec.describe Section, type: :model do
  describe "relationships" do
    it { should belong_to(:report) }
    it { should have_many(:sub_sections) }
    it { should have_many(:parts).through(:sub_sections) }
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
