require 'rails_helper'

RSpec.describe "Part edit pages" do
  describe "final_edit page" do
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
      @user = create_user
    end

    describe "Happy Path" do
      describe "As a logged in user when I visit the page it" do
        before :each do
          login_user(@user)
        end

        it "has a field to add a final assessment" do
          visit part_final_edit_path(@part)

          expect(page).to have_field(:final_assessment)
          expect(page).to have_field(:score)
          expect(page).to have_button("Save assessment")
        end

        it "shows the first assessment information for referance" do
          @part.update!(first_assessment: "This is the first assessment")
          visit part_final_edit_path(@part)

          expect(page).to have_content("This is the first assessment")
        end

        it "it redirects to the section show page with the updated info" do
          visit part_final_edit_path(@part)

          fill_in :final_assessment, with: "This is a final assessment."
          fill_in :score, with: 1
          click_button "Save assessment"

          expect(current_path).to eq(section_path(@section))
        end

        it "has a log-out button" do
          visit part_final_edit_path(@part)

          expect(page).to have_button("Logout")
        end

        it "logs out the user when the log-out button is clicked" do
          visit part_final_edit_path(@part)

          click_button "Logout"

          expect(current_path).to eq(root_path)
          expect(page).to have_content("You have been logged out.")

          visit part_final_edit_path(@part)
          expect(current_path).to eq(root_path)
          expect(page).to have_content("Sorry, your credentials are bad.")
        end
      end
    end

    describe "Sad Path" do
      describe "when a loged out user visits the final edit page it" do
        it "redirects to the login page" do
          visit part_final_edit_path(@part)
          expect(current_path).to eq(root_path)
          expect(page).to have_content("Sorry, your credentials are bad.")
        end
      end
    end
  end

  describe "first_edit page" do
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
      @user = create_user
    end

    describe "Happy Path" do
      describe "As a logged in user when i visit the page it" do
        before :each do
          login_user(@user)
        end

        it "has a field to add the first assessment" do
          visit part_first_edit_path(@part)

          expect(page).to have_field(:first_assessment)
          expect(page).to have_button("Save assessment")
        end

        it "it redirects to the section show page with the updated info" do
          visit part_first_edit_path(@part)

          fill_in :first_assessment, with: "This is the first assessment."
          click_button "Save assessment"

          expect(current_path).to eq(section_path(@section))
        end

        it "has a log-out button" do
          visit part_first_edit_path(@part)

          expect(page).to have_button("Logout")
        end

        it "logs out the user when the log-out button is clicked" do
          visit part_first_edit_path(@part)

          click_button "Logout"

          expect(current_path).to eq(root_path)
          expect(page).to have_content("You have been logged out.")

          visit part_first_edit_path(@part)
          expect(current_path).to eq(root_path)
          expect(page).to have_content("Sorry, your credentials are bad.")
        end
      end
    end

    describe "Sad Path" do
      describe "when a loged out user visits the first edit page it" do
        it "redirects to the login page" do
          visit part_first_edit_path(@part)
          expect(current_path).to eq(root_path)
          expect(page).to have_content("Sorry, your credentials are bad.")
        end
      end
    end
  end
end
