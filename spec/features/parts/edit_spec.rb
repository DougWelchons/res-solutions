require 'rails_helper'

RSpec.describe "Part edit pages" do
  describe "final_edit page" do
    before :each do
      @report = Report.create(name: "Report 1", company: "Sample Company")
      @section = @report.sections.first
      @part = @section.parts.first
      @user = User.create!(name: "Name1", email: "email@domain.com")
    end

    describe "Happy Path" do
      describe "As a logged in user when i visit the page it" do
        before :each do
          visit root_path
          fill_in :email, with: @user.email
          click_button :login
        end

        it "has a field to add a final assessment" do
          visit final_edit_path(@part)

          expect(page).to have_field(:final_assessment)
          expect(page).to have_field(:score)
          expect(page).to have_button("Save assessment")
        end

        it "shows the first assessment information for referance" do
          @part.update!(first_assessment: "This is the first assessment")
          visit final_edit_path(@part)

          expect(page).to have_content("This is the first assessment")
        end

        it "it redirects to the section show page with the updated info" do
          visit final_edit_path(@part)

          fill_in :final_assessment, with: "This is a final assessment."
          fill_in :score, with: 1
          click_button "Save assessment"

          expect(current_path).to eq(section_path(@section))
        end
      end
    end
  end

  describe "first_edit page" do
    before :each do
      @report = Report.create(name: "Report 1", company: "Sample Company")
      @section = @report.sections.first
      @part = @section.parts.first
      @user = User.create!(name: "Name1", email: "email@domain.com")
    end

    describe "Happy Path" do
      describe "As a logged in user when i visit the page it" do
        before :each do
          visit root_path
          fill_in :email, with: @user.email
          click_button :login
        end

        it "has a field to add the first assessment" do
          visit first_edit_path(@part)

          expect(page).to have_field(:first_assessment)
          expect(page).to have_button("Save assessment")
        end

        it "it redirects to the section show page with the updated info" do
          visit first_edit_path(@part)

          fill_in :first_assessment, with: "This is the first assessment."
          click_button "Save assessment"

          expect(current_path).to eq(section_path(@section))
        end
      end
    end
  end
end
