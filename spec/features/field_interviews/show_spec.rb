require 'rails_helper'

RSpec.describe 'Field Interview show page' do
  before :each do
    report = [{section_name: "P1 Ethics", sub_sections: []}]
    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section = @report.sections.first
    @user = create_user
    @field_interview = @user.field_interviews.create!(date: Date.yesterday, time: "04:03", stakeholder: "Stakeholder1", attendees: "Name1", background: "Background1", interview: "interview1", report_summery: "Report Summery1", section: @section)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        login_user(@user)
      end

      it "all of the interviews information as well as an edit link" do
        visit field_interview_path(@field_interview)

        expect(page).to have_content(@field_interview.date)
        expect(page).to have_content(@field_interview.time)
        expect(page).to have_content(@field_interview.stakeholder)
        expect(page).to have_content(@field_interview.attendees)
        expect(page).to have_content(@field_interview.background)
        expect(page).to have_content(@field_interview.interview)
        expect(page).to have_content(@field_interview.report_summery)
        expect(page).to have_content(@user.name)
        expect(page).to have_content(@section.name)
        expect(page).to have_link("Edit Interview")
      end

      it "rediretss to the edit page when the link is clicked" do
        visit field_interview_path(@field_interview)

        click_link "Edit Interview"

        expect(current_path).to eq(edit_section_field_interview_path(@section, @field_interview))
      end

      it "has a log-out button" do
        visit field_interview_path(@field_interview)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit field_interview_path(@field_interview)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit field_interview_path(@field_interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit field_interview_path(@field_interview)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
