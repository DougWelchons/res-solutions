require 'rails_helper'

RSpec.describe "Reports show page" do
  before :each do
    @report = Report.create(name: "Report 1", company: "Sample Company")
  end

  describe "Happy Path" do
    xdescribe "when a logged in user visits the report show page it" do
      it "has a button to 'close' the report" do
        visit report_path(@report)

        expect(page).to have_button("Close Report")
      end

      it "has a link to each section of the report" do
        visit report_path(@report)

        within(".report_sections") do
          expect(page).to have_link("P1 Ethics")
          expect(page).to have_link("P2 Social")
          expect(page).to have_link("P3 Indigenous")
          expect(page).to have_link("P4 Labor")
          expect(page).to have_link("P5 Enviroment")
        end
      end

      it "has a link to the additional documents page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Additional Documents")
        end
      end

      it "has a link to the Field Reviews page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Field Reviews")
        end
      end

      it "has a link to the Interview Questions page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Interview Questions")
        end
      end

      it "has a link to the Interviews page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Interviews")
        end
      end
    end
  end
end
