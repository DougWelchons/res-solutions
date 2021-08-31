require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "relationships" do
    it { should have_many(:sections) }
    it { should have_many(:sub_sections).through(:sections) }
    it { should have_many(:parts).through(:sub_sections) }
  end

  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_uniqueness_of :name}
    it { should validate_presence_of :company}
    it { should define_enum_for(:status).with_values([:prep, :kick_off, :document_review, :field_review, :reporting, :closed]) }

    it "should set the status to prep by default" do
      report = Report.new(name: "report 1", company: "Company")
      expect(report.prep?).to eq(true)
    end
  end

  describe "Instance Methods" do
    it "automatically creates report sections"
  end
end
