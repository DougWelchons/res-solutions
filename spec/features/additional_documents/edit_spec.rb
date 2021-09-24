require 'rails_helper'

RSpec.describe 'Additional Documents Edit page' do
  before :each do
    report = [
      {section_name: "P1 Ethics", sub_sections: [
          {number: "1.1", name: "LEGAL COMPLIANCE", parts: {
            p100: {pt1: 5, pt2: [1], pt3: [1, 5]},
            p101: {pt1: 0, pt2: [], pt3: []},
            p102: {pt1: 0, pt2: [], pt3: []}
          }}]}]

    Builder.build_report({name: "Report 1", company: "Sample Company"}, report)
    @report = Report.first
    @section = @report.sections.first
    @part = @section.parts.first
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @additional_document1 = @part.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes", user: @user)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows a field to add the needed document and notes" do
        visit edit_part_additional_document_path(@part, @additional_document1)

        expect(page).to have_field(:document, with: "Doc1")
        expect(page).to have_field(:notes, with: "Lots'O'Notes")
        expect(page).to have_button("Update")
      end

      it "updates the object and redirects to the section show page when the Update button is clicked" do
        visit edit_part_additional_document_path(@part, @additional_document1)

        fill_in :document, with: "Document Name"
        fill_in :notes, with: "Notes about needed document"
        click_button "Update"

        expect(current_path).to eq(section_path(@section))

        within "#part-#{@part.id}" do
          within ".additional_documents" do
            within "#additional_document-#{@additional_document1.id}" do
              expect(page).to have_content("Document: Document Name")
              expect(page).to have_content("Notes: Notes about needed document")
            end
          end
        end
      end

      it "retrurns to the Edit page if the document is not provided" do
        visit edit_part_additional_document_path(@part, @additional_document1)

        fill_in :document, with: ""
        click_button "Update"

        expect(current_path).to eq(edit_part_additional_document_path(@part, @additional_document1))
      end

      it "has a log-out button" do
        visit edit_part_additional_document_path(@part, @additional_document1)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit edit_part_additional_document_path(@part, @additional_document1)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit edit_part_additional_document_path(@part, @additional_document1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit edit_part_additional_document_path(@part, @additional_document1)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
