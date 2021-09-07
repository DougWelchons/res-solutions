require 'rails_helper'

RSpec.describe "section show page" do
  describe "Happy Path" do
    before :each do
      @report = Report.create(name: "Report 1", company: "Sample Company")
      @section = @report.sections.first
    end

    describe "as a logged in user, when I visit the section show page it" do
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
        @part = @section.parts.first
        visit section_path(@section)

        within "#part-#{@section.parts.first.id}" do
          within ".first_assessment" do
            expect(page).to have_button("Edit")
          end
        end
      end

      it "redirects to the first assessment edit page" do
        visit section_path(@section)

        within "#part-#{@section.parts.first.id}" do
          within ".first_assessment" do
            click_button "Edit"
          end
        end

        expect(current_path).to eq(first_edit_path(@section.parts.first))
      end

      it "has a final assessment edit button" do
        visit section_path(@section)

        within "#part-#{@section.parts.first.id}" do
          within ".final_assessment" do
            expect(page).to have_button("Edit")
          end
        end
      end

      it "redirects to the final assessment edit page" do
        visit section_path(@section)
save_and_open_page
        within "#part-#{@section.parts.first.id}" do
          within ".final_assessment" do
            click_button "Edit"
          end
        end

        expect(current_path).to eq(final_edit_path(@section.parts.first))
      end
    end
  end
end
