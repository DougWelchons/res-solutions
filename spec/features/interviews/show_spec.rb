require 'rails_helper'

RSpec.describe 'Additional Documents show page' do
  before :each do
    @report = Report.create!(name: "Report 1", company: "Sample Company")
    @section = @report.sections.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @interview = @user.interviews.create!(date: Date.yesterday, time: "04:03", stakeholder: "Stakeholder1", attendees: "Name1", background: "Background1", interview: "interview1", report_summery: "Report Summery1", section: @section)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "all of the interviews information as well as an edit link" do
        visit interview_path(@interview)

        expect(page).to have_content(@interview.date)
        expect(page).to have_content(@interview.time)
        expect(page).to have_content(@interview.stakeholder)
        expect(page).to have_content(@interview.attendees)
        expect(page).to have_content(@interview.background)
        expect(page).to have_content(@interview.interview)
        expect(page).to have_content(@interview.report_summery)
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@section.name)
        expect(page).to have_link("Edit Interview")
      end

      it "rediretss to the edit page when the link is clicked" do
        visit interview_path(@interview)

        click_link "Edit Interview"

        expect(current_path).to eq(edit_section_interview_path(@section, @interview))
      end

      it "has a log-out button" do
        visit interview_path(@interview)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit interview_path(@interview)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit interview_path(@interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit interview_path(@interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
