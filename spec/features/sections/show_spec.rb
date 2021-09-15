require 'rails_helper'

RSpec.describe "section show page" do
  before :each do
    @report = Report.create(name: "Report 1", company: "Sample Company")
    @section = @report.sections.first
    @part = @section.parts.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
  end

  describe "Happy Path" do
    describe "as a logged in user, when I visit the section show page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows the section name at the top of the page" do
        visit section_path(@section)

        expect(page).to have_content("#{@section.name}")
      end

      it "shows each subsection number and name" do
        visit section_path(@section)

        @section.sub_sections.each do |sub_section|
          expect(page).to have_content("#{sub_section.section_number} #{sub_section.name}")
        end
      end

      it "has a first assessment edit button" do
        visit section_path(@section)

        within "#part-#{@part.id}" do
          within ".first_assessment" do
            expect(page).to have_button("Edit")
          end
        end
      end

      it "redirects to the first assessment edit page" do
        visit section_path(@section)

        within "#part-#{@part.id}" do
          within ".first_assessment" do
            click_button "Edit"
          end
        end

        expect(current_path).to eq(part_first_edit_path(@part))
      end

      it "has a final assessment edit button" do
        visit section_path(@section)

        within "#part-#{@part.id}" do
          within ".final_assessment" do
            expect(page).to have_button("Edit")
          end
        end
      end

      it "redirects to the final assessment edit page" do
        visit section_path(@section)

        within "#part-#{@part.id}" do
          within ".final_assessment" do
            click_button "Edit"
          end
        end

        expect(current_path).to eq(part_final_edit_path(@part))
      end

      it "has a log-out button" do
        visit section_path(@section)

        expect(page).to have_button("Logout")
      end

      describe "Additional Documents" do
        before :each do
          @additional_document1 = @part.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes", user: @user)
          @additional_document2 = @part.additional_documents.create!(document: "Doc2", notes: "All the notes!", user: @user)
        end

        it "has a button to add new additional document requests" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".additional_documents" do
              expect(page).to have_button("Add")
            end
          end
        end

        it "redirects to the add doc new page when clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".additional_documents" do
              click_button "Add"
            end
          end

          expect(current_path).to eq(new_part_additional_document_path(@part))
        end

        it "shows each additional document that has already been requested" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".additional_documents" do
              within "#additional_document-#{@additional_document1.id}" do
                expect(page).to have_content("Document: Doc1")
                expect(page).to have_content("Notes: Lots'O'Notes")
                expect(page).to have_button("Edit")
              end

              within "#additional_document-#{@additional_document2.id}" do
                expect(page).to have_button("Edit")
                expect(page).to have_content("Document: Doc2")
                expect(page).to have_content("Notes: All the notes!")
              end
            end
          end
        end

        it "redirects to the additional_document edit page when the edit link is clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".additional_documents" do
              within "#additional_document-#{@additional_document2.id}" do
                click_button "Edit"
              end
            end
          end

          expect(current_path).to eq(edit_part_additional_document_path(@part, @additional_document2))
        end
      end

      describe "Interview Questions" do
        before :each do
          @interview_question1 = @part.interview_questions.create!(question: "question1", notes: "Lots'O'Notes", user: @user)
          @interview_question2 = @part.interview_questions.create!(question: "question2", notes: "All the notes!", user: @user)
        end

        it "has a button to add new interview questions" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".interview_questions" do
              expect(page).to have_button("Add")
            end
          end
        end

        it "redirects to the interview question new page when clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".interview_questions" do
              click_button "Add"
            end
          end

          expect(current_path).to eq(new_part_interview_question_path(@part))
        end

        it "shows each interview question that has already been requested" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".interview_questions" do
              within "#interview_question-#{@interview_question1.id}" do
                expect(page).to have_content("Question: question1")
                expect(page).to have_content("Notes: Lots'O'Notes")
                expect(page).to have_button("Edit")
              end

              within "#interview_question-#{@interview_question2.id}" do
                expect(page).to have_button("Edit")
                expect(page).to have_content("Question: question2")
                expect(page).to have_content("Notes: All the notes!")
              end
            end
          end
        end

        it "redirects to the interview question edit page when the edit link is clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".interview_questions" do
              within "#interview_question-#{@interview_question2.id}" do
                click_button "Edit"
              end
            end
          end

          expect(current_path).to eq(edit_part_interview_question_path(@part, @interview_question2))
        end
      end

      describe "Interviews" do
        it "has a link to the interviews index page" do
          visit section_path(@section)

          within ".interviews" do
            expect(page).to have_link("Interviews")
            click_link("Interviews")
          end

          expect(current_path).to eq(section_interviews_path(@section))
        end

        it "has a link to start a new interview" do
          visit section_path(@section)

          within ".interviews" do
            expect(page).to have_link("New Interview")
            click_link("New Interview")
          end

          expect(current_path).to eq(new_section_interview_path(@section))
        end
      end

      it "logs out the user when the log-out button is clicked" do
        visit section_path(@section)

        click_button "Logout"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit section_path(@section)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the section show page it" do
      it "redirects to the login page" do
        visit section_path(@section)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
