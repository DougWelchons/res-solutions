require 'rails_helper'

RSpec.describe 'Interview Edit page' do
  before :each do
    @report = Report.create!(name: "Report 1", company: "Sample Company")
    @section = @report.sections.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @interview = @user.interviews.create!(stakeholder: "Stakeholder", background: "Background", section: @section)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows all interview fields" do
        visit edit_section_interview_path(@section, @interview)

        expect(page).to have_field("interview[date]")
        expect(page).to have_field("interview[time]")
        expect(page).to have_field("interview[stakeholder]", with: "Stakeholder")
        expect(page).to have_field("interview[attendees]")
        expect(page).to have_field("interview[background]", with: "Background")
        expect(page).to have_field("interview[interview]")
        expect(page).to have_field("interview[report_summery]")
        expect(page).to have_button("Update Interview")
      end

      it "updates an interview object and redirects to the report show page when the Update button is clicked" do
        visit edit_section_interview_path(@section, @interview)

        fill_in "interview[date]", with: "Interview"
        click_button "Update Interview"

        expect(current_path).to eq(report_path(@report))
      end

      it "has a log-out button" do
        visit edit_section_interview_path(@section, @interview)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit edit_section_interview_path(@section, @interview)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit edit_section_interview_path(@section, @interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit edit_section_interview_path(@section, @interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
