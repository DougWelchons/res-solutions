require 'rails_helper'

RSpec.describe 'Interview Question New page' do
  before :each do
    @report = Report.create(name: "Report 1", company: "Sample Company")
    @section = @report.sections.first
    @part = @section.parts.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows a field to add the question and notes" do
        visit new_part_interview_question_path(@part)

        expect(page).to have_field(:question)
        expect(page).to have_field(:notes)
        expect(page).to have_button("Create")
      end

      it "creates an interview question object and redirects to the section show page when the create button is clicked" do
        visit new_part_interview_question_path(@part)

        fill_in :question, with: "This is my question"
        fill_in :notes, with: "Notes about the question"
        click_button "Create"

        expect(current_path).to eq(section_path(@section))

        # within "#part-#{@part.id}" do
        #   within ".add_docs" do
        #     expect(page).to have_content("Question: This is my question")
        #     expect(page).to have_content("Notes: Notes about the question")
        #   end
        # end
      end

      it "retrurns to the new page if the question is not provided" do
        visit new_part_interview_question_path(@part)

        fill_in :notes, with: "Notes about the question"
        click_button "Create"

        expect(current_path).to eq(new_part_interview_question_path(@part))
        # expect(page).to have_content("Validation failed: Document can't be blank")

        fill_in :question, with: "This is my question"
        fill_in :notes, with: "Notes about the question"
        click_button "Create"

        expect(current_path).to eq(section_path(@section))

        # within "#part-#{@part.id}" do
        #   within ".add_docs" do
        #     expect(page).to have_content("Document: This is my question")
        #     expect(page).to have_content("Notes: Notes about the question")
        #   end
        # end
      end

      it "has a log-out button" do
        visit new_part_interview_question_path(@part)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit new_part_interview_question_path(@part)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit new_part_interview_question_path(@part)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit new_part_interview_question_path(@part)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
