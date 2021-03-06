require 'rails_helper'

RSpec.describe "Reports show page" do
  before :each do
    report = [
                {section_name: "P1 Ethics", sub_sections: []},
                {section_name: "P2 Social", sub_sections: []},
                {section_name: "P3 Indigenous", sub_sections: []},
                {section_name: "P4 Labor", sub_sections: []},
                {section_name: "P5 Enviroment", sub_sections: []}
              ]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first

    @user = create_user
  end

  describe "Happy Path" do
    describe "when a logged in user visits the report show page it" do
      before :each do
        login_user(@user)
      end

      xit "has a button to 'close' the report" do
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

      it "redirects to the additional documents page" do
        visit report_path(@report)

        within(".additional_info") do
          click_link("Additional Documents")
        end

        expect(current_path).to eq(report_additional_documents_path(@report))
      end

      it "has a link to the Interview Questions page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Interview Questions")
        end
      end

      it "redirects to the interview questions page" do
        visit report_path(@report)

        within(".additional_info") do
          click_link("Interview Questions")
        end

        expect(current_path).to eq(report_interview_questions_path(@report))
      end

      it "has a link to the Interviews page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Interviews")
        end
      end

      it "redirects to the interview page" do
        visit report_path(@report)

        within(".additional_info") do
          click_link("Interviews")
        end

        expect(current_path).to eq(report_interviews_path(@report))
      end

      it "has a link to the  Field Interview Questions page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Field Interview Questions")
        end
      end

      it "redirects to the field interview questions page" do
        visit report_path(@report)

        within(".additional_info") do
          click_link("Field Interview Questions")
        end

        expect(current_path).to eq(report_field_interview_questions_path(@report))
      end

      it "has a link to the Field Interviews page" do
        visit report_path(@report)

        within(".additional_info") do
          expect(page).to have_link("Field Interviews")
        end
      end

      it "redirects to the interview page" do
        visit report_path(@report)

        within(".additional_info") do
          click_link("Field Interviews")
        end

        expect(current_path).to eq(report_field_interviews_path(@report))
      end

      it "has a log-out button" do
        visit report_path(@report)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit report_path(@report)

        click_button "Logout"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit report_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the report show page it" do
      it "redirects to the login page" do
        visit report_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
