require 'rails_helper'

RSpec.describe FieldInterview, type: :model do
  describe "relationships" do
    it { should belong_to(:section) }
    it { should belong_to(:user) }
    it { should have_one(:report).through(:section) }
  end
end
