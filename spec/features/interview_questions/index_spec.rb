require 'rails_helper'

RSpec.describe 'interview questions index page' do
  before :each do
    report = [
      {section_name: "P1 Ethics", sub_sections: [
          {number: "1.1", name: "LEGAL COMPLIANCE", parts: {
            p100: {pt1: 5, pt2: [1], pt3: [1, 5]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]},
      {section_name: "P2 Social", sub_sections: [
          {number: "2.1", name: "HUMAN RIGHTS", parts: {
            p100: {pt1: 4, pt2: [1, 2], pt3: [1, 2, 3]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]},
      {section_name: "P5 Enviroment", sub_sections: [
          {number: "5.1", name: "ENVIRONMENTAL MANAGEMENT & MITIGATION", parts: {
            p100: {pt1: 3, pt2: [1, 3], pt3: [1, 3]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]}]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section1 = @report.sections.first
    @section2 = @report.sections.second
    @section3 = @report.sections.last
    @part1 = @section1.parts.first
    @part2 = @section2.parts.second
    @part3 = @section1.parts.fifth
    @part4 = @section3.parts.third
    @part5 = @section3.parts.fourth
    @user = create_user
    @interview_question1 = @part1.interview_questions.create!(question: "Question1", notes: "Lots'O'Notes1", user: @user)
    @interview_question2 = @part2.interview_questions.create!(question: "Question2", notes: "Lots'O'Notes2", user: @user)
    @interview_question3 = @part1.interview_questions.create!(question: "Question3", notes: "Lots'O'Notes3", user: @user)
    @interview_question4 = @part3.interview_questions.create!(question: "Question4", notes: "Lots'O'Notes4", user: @user)
    @interview_question5 = @part4.interview_questions.create!(question: "Question5", notes: "Lots'O'Notes5", user: @user)
    @interview_question6 = @part5.interview_questions.create!(question: "Question6", notes: "Lots'O'Notes6", user: @user)
    @interview_question7 = @part5.interview_questions.create!(question: "Question7", notes: "Lots'O'Notes7", user: @user)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        login_user(@user)
      end

      # it "lists all of a reports interview questions sorted by its associated part number" do
      #   visit report_interview_questions_path(@report)
      #
      #   expect(@interview_question1.question).to appear_before(@interview_question3.question)
      #   expect(@interview_question3.question).to appear_before(@interview_question4.question)
      #   expect(@interview_question4.question).to appear_before(@interview_question2.question)
      #   expect(@interview_question2.question).to appear_before(@interview_question5.question)
      #   expect(@interview_question5.question).to appear_before(@interview_question6.question)
      #   expect(@interview_question6.question).to appear_before(@interview_question7.question)
      # end

      it "lists each questions part number, question, notes, and assessor" do
        visit report_interview_questions_path(@report)

        within "#question-#{@interview_question1.id}" do
          expect(page).to have_content(@interview_question1.part.section_number)
          expect(page).to have_content(@interview_question1.question)
          expect(page).to have_content(@interview_question1.notes)
          expect(page).to have_content(@interview_question1.user.name)
        end
      end

      it "has a log-out button" do
        visit report_interview_questions_path(@report)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit report_interview_questions_path(@report)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit report_interview_questions_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit report_interview_questions_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
