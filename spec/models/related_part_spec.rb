require 'rails_helper'

RSpec.describe RelatedPart, type: :model do
  describe "relationships" do
    it { should have_one(:pt1) }
    it { should have_one(:pt2) }
    it { should have_one(:pt3) }
    it {should have_one(:sub_section).through(:pt1) }
    it {should have_one(:sub_section).through(:pt2) }
    it {should have_one(:sub_section).through(:pt3) }
  end
end
