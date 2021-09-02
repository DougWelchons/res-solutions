require 'rails_helper'

RSpec.describe RelatedPart, type: :model do
  describe "relationships" do
    it { should have_one(:pt1) }
    it { should have_one(:pt2) }
    it { should have_one(:pt3) }
  end
end
