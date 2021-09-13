require 'rails_helper'

RSpec.describe 'Interview Question Edit page' do
  before :each do
    @report = Report.create!(name: "Report 1", company: "Sample Company")
    @section = @report.sections.first
    @part = @section.parts.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @interview_question = @part.interview_questions.create!(question: "My Question", notes: "Lots'O'Notes", user: @user)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows a field to add the question and notes" do
        visit edit_part_interview_question_path(@part, @interview_question)

        expect(page).to have_field(:question, with: "My Question")
        expect(page).to have_field(:notes, with: "Lots'O'Notes")
        expect(page).to have_button("Update")
      end

      it "updates the object and redirects to the section show page when the Update button is clicked" do
        visit edit_part_interview_question_path(@part, @interview_question)

        fill_in :question, with: "Changed Question"
        fill_in :notes, with: "Notes about the question"
        click_button "Update"

        expect(current_path).to eq(section_path(@section))

        within "#part-#{@part.id}" do
          within ".interview_questions" do
            within "#interview_question-#{@interview_question.id}" do
              expect(page).to have_content("Question: Changed Question")
              expect(page).to have_content("Notes: Notes about the question")
            end
          end
        end
      end

      it "retrurns to the Edit page if the question is not provided" do
        visit edit_part_interview_question_path(@part, @interview_question)

        fill_in :question, with: ""
        click_button "Update"

        expect(current_path).to eq(edit_part_interview_question_path(@part, @interview_question))
      end

      it "has a log-out button" do
        visit edit_part_interview_question_path(@part, @interview_question)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit edit_part_interview_question_path(@part, @interview_question)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit edit_part_interview_question_path(@part, @interview_question)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit edit_part_interview_question_path(@part, @interview_question)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
