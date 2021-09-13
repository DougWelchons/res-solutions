require 'rails_helper'

RSpec.describe Report, type: :model do
  describe "relationships" do
    it { should have_many(:sections) }
    it { should have_many(:sub_sections).through(:sections) }
    it { should have_many(:parts).through(:sub_sections) }
    it { should have_many(:related_pt1s).through(:parts) }
    it { should have_many(:related_pt2s).through(:parts) }
    it { should have_many(:related_pt3s).through(:parts) }
    it { should have_many(:additional_documents).through(:parts) }
    it { should have_many(:interviews).through(:sections) }
    it { should have_many(:interview_questions).through(:parts) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:company) }
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
