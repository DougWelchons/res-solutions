require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_uniqueness_of :name}
    it { should validate_presence_of :company}
    it { should define_enum_for(:status).with_values([:open, :closed]) }
    it "should set the status to open by default" do
      report = Report.new(name: "report 1", company: "Company")
      expect(report.open?).to eq(true)
    end
  end

  describe "Instance Methods" do
    it "automatically creates report sections"
  end
end
