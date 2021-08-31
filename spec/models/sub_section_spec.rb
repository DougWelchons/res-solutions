require 'rails_helper'

RSpec.describe SubSection, type: :model do
  describe "relationships" do
    it { should belong_to(:section) }
    it { should have_one(:report).through(:section) }
    it { should have_many(:parts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    # it { should validate_uniqueness_of(:name).scoped_to(:section_id) }
    it { should validate_presence_of(:section_number) }
    # it { should validate_uniqueness_of(:section_number).scoped_to(:section_id) }
  end

  describe "Instance Methods" do
    it "automatically creates report parts"
  end
end
