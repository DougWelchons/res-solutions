require 'rails_helper'

RSpec.describe 'Field Interviews index page' do
  before :each do
    report = [
                {section_name: "P1 Ethics", sub_sections: []},
                {section_name: "P2 Social", sub_sections: []},
                {section_name: "P5 Enviroment", sub_sections: []}
              ]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    Builder.build_report({name: "Report 2", company: "Sample Company"}, report)
    @report = Report.first
    @report2 = Report.second
    @section1 = @report.sections.first
    @section2 = @report.sections.second
    @section3 = @report.sections.last
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @field_interview1 = @user.field_interviews.create!(date: Date.yesterday, time: "04:15", stakeholder: "Stakeholder1", background: "Background1", interview: "interview1", report_summery: "Report Summery1", section: @section1)
    @field_interview2 = @user.field_interviews.create!(date: Date.yesterday, time: "04:20", stakeholder: "Stakeholder2", background: "Background2", interview: "interview2", report_summery: "Report Summery2", section: @section2)
    @field_interview3 = @user.field_interviews.create!(date: Date.yesterday, time: "15:15", stakeholder: "Stakeholder3", background: "Background3", interview: "interview3", report_summery: "Report Summery3", section: @section1)
    @field_interview4 = @user.field_interviews.create!(date: Date.yesterday, time: "20:15", stakeholder: "Stakeholder4", background: "Background4", interview: "interview4", report_summery: "Report Summery4", section: @section3)
    @field_interview5 = @user.field_interviews.create!(date: Date.yesterday, time: "19:30", stakeholder: "Stakeholder5", background: "Background5", interview: "interview5", report_summery: "Report Summery5", section: @section1)
    @field_interview6 = @user.field_interviews.create!(date: Date.yesterday, time: "04:15", stakeholder: "Stakeholder1", background: "Background1", interview: "interview1", report_summery: "Report Summery1", section: @report2.sections.first)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      # it "lists all of a reports interviews sorted by its associated section" do
      #   visit report_field_interviews_path(@report)
      #
      #   expect(@field_interview1.report_summery).to appear_before(@field_interview3.report_summery)
      #   expect(@field_interview3.report_summery).to appear_before(@field_interview5.report_summery)
      #   expect(@field_interview5.report_summery).to appear_before(@field_interview2.report_summery)
      #   expect(@field_interview2.report_summery).to appear_before(@field_interview4.report_summery)
      # end

      it "lists each interviews date, time, stakeholder, report summery and a link to view interview show page" do
        visit report_field_interviews_path(@report)

        within "#field_interview-#{@field_interview1.id}" do
          expect(page).to have_content(@field_interview1.date)
          expect(page).to have_content(@field_interview1.time)
          expect(page).to have_content(@field_interview1.stakeholder)
          expect(page).to have_content(@field_interview1.report_summery)
          expect(page).to have_link("View Full Interview")
        end
      end

      it "lists each interview in a section" do
        visit section_field_interviews_path(@section1)

        expect(page).to have_content(@field_interview1.report_summery)
        expect(page).to have_content(@field_interview3.report_summery)
        expect(page).to have_content(@field_interview5.report_summery)
      end

      it "lists each interview in a report" do
        visit report_field_interviews_path(@report)

        expect(page).to have_content(@field_interview1.report_summery)
        expect(page).to have_content(@field_interview2.report_summery)
        expect(page).to have_content(@field_interview3.report_summery)
        expect(page).to have_content(@field_interview4.report_summery)
        expect(page).to have_content(@field_interview5.report_summery)
      end

      it "lists all interviews if no section or report is provided" do
        visit field_interviews_path

        expect(page).to have_content(@field_interview1.report_summery)
        expect(page).to have_content(@field_interview2.report_summery)
        expect(page).to have_content(@field_interview3.report_summery)
        expect(page).to have_content(@field_interview4.report_summery)
        expect(page).to have_content(@field_interview5.report_summery)
        expect(page).to have_content(@field_interview6.report_summery)
      end

      it "lists each interviews date, time, stakeholder, report summery and a link to view interview show page" do
        visit report_field_interviews_path(@report)

        within "#field_interview-#{@field_interview1.id}" do
          click_link("View Full Interview")
        end

        expect(current_path).to eq(field_interview_path(@field_interview1))
      end

      it "has a log-out button" do
        visit report_field_interviews_path(@report)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit report_field_interviews_path(@report)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit report_field_interviews_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit report_field_interviews_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
