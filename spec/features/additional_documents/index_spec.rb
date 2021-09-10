require 'rails_helper'

RSpec.describe 'Additional Documents Edit page' do
  before :each do
    @report = Report.create!(name: "Report 1", company: "Sample Company")
    @section1 = @report.sections.first
    @section2 = @report.sections.second
    @section3 = @report.sections.last
    @part1 = @section1.parts.first
    @part2 = @section2.parts.second
    @part3 = @section1.parts.fifth
    @part4 = @section3.parts.third
    @part5 = @section3.parts.fourth
    @user = User.create!(name: "Name1", email: "email@domain.com")
    @add_doc1 = @part1.additional_documents.create!(document: "Doc1", notes: "Lots'O'Notes1", user: @user)
    @add_doc2 = @part2.additional_documents.create!(document: "Doc2", notes: "Lots'O'Notes2", user: @user)
    @add_doc3 = @part1.additional_documents.create!(document: "Doc3", notes: "Lots'O'Notes3", user: @user)
    @add_doc4 = @part3.additional_documents.create!(document: "Doc4", notes: "Lots'O'Notes4", user: @user)
    @add_doc5 = @part4.additional_documents.create!(document: "Doc5", notes: "Lots'O'Notes5", user: @user)
    @add_doc6 = @part5.additional_documents.create!(document: "Doc6", notes: "Lots'O'Notes6", user: @user)
    @add_doc7 = @part5.additional_documents.create!(document: "Doc7", notes: "Lots'O'Notes7", user: @user)
  end

  describe "Happy path" do
    describe "As a logged in user when I visit the page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      xit "lists all of a reports additional documents" do
        visit report_additional_documents_path(@report)

        expect(page).to have_content
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
