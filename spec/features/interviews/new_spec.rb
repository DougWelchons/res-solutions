require 'rails_helper'

RSpec.describe 'Interview New page' do
  before :each do
    report = [{section_name: "P1 Ethics", sub_sections: []}]
    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section = @report.sections.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows all interview fields" do
        visit new_section_interview_path(@section)

        expect(page).to have_field(:date)
        expect(page).to have_field(:time)
        expect(page).to have_field(:stakeholder)
        expect(page).to have_field(:attendees)
        expect(page).to have_field(:background)
        expect(page).to have_field(:interview)
        expect(page).to have_field(:report_summery)
        expect(page).to have_button("Save")
      end

      it "creates an interview object and redirects to the report show page when the create button is clicked" do
        visit new_section_interview_path(@section)

        click_button "Save"

        expect(current_path).to eq(report_path(@report))
      end

      it "has a log-out button" do
        visit new_section_interview_path(@section)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit new_section_interview_path(@section)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit new_section_interview_path(@section)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit new_section_interview_path(@section)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
