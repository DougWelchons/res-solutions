require 'rails_helper'

RSpec.describe 'Additional Documents index page' do
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
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @additional_document1 = @part1.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes1", user: @user)
    @additional_document2 = @part2.additional_documents.create!(document: "Doc2", notes: "Lots'O'Notes2", user: @user)
    @additional_document3 = @part1.additional_documents.create!(document: "Doc3", notes: "Lots'O'Notes3", user: @user)
    @additional_document4 = @part3.additional_documents.create!(document: "Doc4", notes: "Lots'O'Notes4", user: @user)
    @additional_document5 = @part4.additional_documents.create!(document: "Doc5", notes: "Lots'O'Notes5", user: @user)
    @additional_document6 = @part5.additional_documents.create!(document: "Doc6", notes: "Lots'O'Notes6", user: @user)
    @additional_document7 = @part5.additional_documents.create!(document: "Doc7", notes: "Lots'O'Notes7", user: @user)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      # it "lists all of a reports additional documents sorted by its associated part number" do
      #   visit report_additional_documents_path(@report)
      #
      #   expect(@additional_document1.document).to appear_before(@additional_document3.document)
      #   expect(@additional_document3.document).to appear_before(@additional_document4.document)
      #   expect(@additional_document4.document).to appear_before(@additional_document2.document)
      #   expect(@additional_document2.document).to appear_before(@additional_document5.document)
      #   expect(@additional_document5.document).to appear_before(@additional_document6.document)
      #   expect(@additional_document6.document).to appear_before(@additional_document7.document)
      # end

      it "lists each documents part number, document, notes, and assessor" do
        visit report_additional_documents_path(@report)

        within "#document-#{@additional_document1.id}" do
          expect(page).to have_content(@additional_document1.part.section_number)
          expect(page).to have_content(@additional_document1.document)
          expect(page).to have_content(@additional_document1.notes)
          expect(page).to have_content(@additional_document1.user.name)
        end
      end

      it "has a log-out button" do
        visit report_additional_documents_path(@report)

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit report_additional_documents_path(@report)

        click_button "Logout"
        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit report_additional_documents_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the new additional document page it" do
      it "redirects to the login page" do
        visit report_additional_documents_path(@report)
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
