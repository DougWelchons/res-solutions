require 'rails_helper'

RSpec.describe "nav-bar" do
  before :each do
    report = [
      {section_name: "P1 Ethics", sub_sections: [
          {number: "1.1", name: "LEGAL COMPLIANCE", parts: {
            p100: {pt1: 5, pt2: [1], pt3: [1, 5]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]}]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section = @report.sections.first
    @part = @section.parts.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @additional_document = @part.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes", user: @user)
    @interview_question = @part.interview_questions.create!(question: "Doc1", notes: "Lots'O'Notes", user: @user)
    @interview = Interview.create!(user: @user, section: @section)
  end

  describe "Welcome" do
    it "index" do
      visit root_path

      within ".nav-bar" do
        expect(page).to_not have_button("Logout")
        expect(page).to_not have_button("Home")
        expect(page).to_not have_button("Report")
        expect(page).to_not have_button("Section")
      end
    end
  end

  describe "Logged in" do
    before :each do
      visit root_path
      fill_in :email, with: @user.email
      click_button :login
    end

    describe "Reports" do
      it "index" do
        visit reports_path

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "show" do
        visit report_path(@report)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end
    end

    describe "Sections" do
      it "show" do
        visit section_path(@section)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end
    end

    describe "Parts" do
      it "first_edit" do
        visit part_first_edit_path(@part)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "final_edit" do
        visit part_final_edit_path(@part)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

    end

    describe "Additional Documents" do
      it "index" do
        visit report_additional_documents_path(@report)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "new" do
        visit new_part_additional_document_path(@part)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "edit" do
        visit edit_part_additional_document_path(@part, @additional_document)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end
    end

    describe "Interview Questions" do
      it "index" do
        visit report_interview_questions_path(@report)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "new" do
        visit new_part_interview_question_path(@part)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "edit" do
        visit edit_part_interview_question_path(@part, @interview_question)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end
    end

    describe "Interviews" do
      it "index" do
        visit report_interviews_path(@report)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to_not have_button("Section")
        end

        visit section_interviews_path(@section)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to have_button("Section")
        end
      end

      it "show" do
        visit interview_path(@interview)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to have_button("Home")
          expect(page).to have_button("Report")
          expect(page).to have_button("Section")
        end
      end
      it "new" do
        visit new_section_interview_path(@section)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end

      it "edit" do
        visit edit_section_interview_path(@section, @interview)

        within ".nav-bar" do
          expect(page).to have_button("Logout")
          expect(page).to_not have_button("Home")
          expect(page).to_not have_button("Report")
          expect(page).to_not have_button("Section")
        end
      end
    end
  end
end
