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
    end
  end
end
