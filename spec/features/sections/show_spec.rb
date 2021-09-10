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
          @add_doc1 = @part.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes", user: @user)
          @add_doc2 = @part.additional_documents.create!(document: "Doc2", notes: "All the notes!", user: @user)
        end

        it "has a button to add new additional document requests" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".add_docs" do
              expect(page).to have_button("Add")
            end
          end
        end

        it "redirects to the add doc new page when clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".add_docs" do
              click_button "Add"
            end
          end

          expect(current_path).to eq(new_part_additional_document_path(@part))
        end

        it "shows each additional document that has already been requested" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".add_docs" do
              within "#add_doc-#{@add_doc1.id}" do
                expect(page).to have_content("Document: Doc1")
                expect(page).to have_content("Notes: Lots'O'Notes")
                expect(page).to have_button("Edit")
              end

              within "#add_doc-#{@add_doc2.id}" do
                expect(page).to have_button("Edit")
                expect(page).to have_content("Document: Doc2")
                expect(page).to have_content("Notes: All the notes!")
              end
            end
          end
        end

        it "redirects to the add_doc edit page when the edit link is clicked" do
          visit section_path(@section)

          within "#part-#{@part.id}" do
            within ".add_docs" do
              within "#add_doc-#{@add_doc2.id}" do
                click_button "Edit"
              end
            end
          end

          expect(current_path).to eq(edit_part_additional_document_path(@part, @add_doc2))
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
