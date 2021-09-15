require 'rails_helper'

RSpec.describe Interview, type: :model do
  describe "relationships" do
    it { should belong_to(:section) }
    it { should belong_to(:user) }
    it { should have_one(:report).through(:section) }
  end
end
