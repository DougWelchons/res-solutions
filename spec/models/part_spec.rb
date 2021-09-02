require 'rails_helper'

RSpec.describe Part, type: :model do
  describe "relationships" do
    it { should belong_to(:sub_section) }
    it { should have_one(:user) }
    it { should have_one(:section).through(:sub_section) }
    it { should have_one(:report).through(:section) }
  end

  describe "validations" do
    it { should validate_presence_of(:section_number) }
    # it { should validate_uniqueness_of(:section_number).scoped_to(:sub_section_id) }
  end
end
