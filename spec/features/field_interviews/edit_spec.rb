require 'rails_helper'

RSpec.describe 'Field Interview Edit page' do
  before :each do
    report = [{section_name: "P1 Ethics", sub_sections: []}]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section = @report.sections.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @field_interview = @user.field_interviews.create!(stakeholder: "Stakeholder", background: "Background", section: @section)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows all interview fields" do
        visit edit_section_field_interview_path(@section, @field_interview)

        expect(page).to have_field("field_interview[date]")
        expect(page).to have_field("field_interview[time]")
        expect(page).to have_field("field_interview[stakeholder]", with: "Stakeholder")
        expect(page).to have_field("field_interview[attendees]")
        expect(page).to have_field("field_interview[background]", with: "Background")
        expect(page).to have_field("field_interview[interview]")
        expect(page).to have_field("field_interview[report_summery]")
        expect(page).to have_button("Update Field interview")
      end

      it "updates an interview object and redirects to the report show page when the Update button is clicked" do
        visit edit_section_field_interview_path(@section, @field_interview)

        fill_in "field_interview[date]", with: "Interview"
        click_button "Update Field interview"

        expect(current_path).to eq(report_path(@report))
      end

      it "has a log-out button" do
        visit edit_section_field_interview_path(@section, @field_interview)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit edit_section_field_interview_path(@section, @field_interview)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit edit_section_field_interview_path(@section, @field_interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit edit_section_field_interview_path(@section, @field_interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
