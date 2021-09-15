require 'rails_helper'

RSpec.describe InterviewQuestion, type: :model do
  describe "relationships" do
    it { should belong_to(:part) }
    it { should belong_to(:user) }
    it { should have_one(:sub_section).through(:part) }
    it { should have_one(:section).through(:sub_section) }
    it { should have_one(:report).through(:section) }
  end

  describe "validations" do
    it { should validate_presence_of(:question) }
  end
end
