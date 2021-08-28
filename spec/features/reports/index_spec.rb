require 'rails_helper'

RSpec.describe "Reports index page" do
  before :each do
    @report1 = Report.create(name: "Report 1", company: "Sample Company")
    @report2 = Report.create(name: "Report 2", company: "Sample Company", status: 1)
    @report3 = Report.create(name: "Report 3", company: "Sample Company")
    @report4 = Report.create(name: "Report 4", company: "Sample Company")
    @report5 = Report.create(name: "Report 5", company: "Sample Company", status: 1)
    @report6 = Report.create(name: "Report 6", company: "Sample Company", status: 1)
    @report7 = Report.create(name: "Report 7", company: "Sample Company", status: 1)
    @report8 = Report.create(name: "Report 8", company: "Sample Company")
  end

  describe "Happy Path" do
    describe "when a loged in user visits the reports index page it" do
      it "shows all of the current reports" do
        visit reports_path

        within(".reports") do
          within(".open") do
            expect(page).to have_link("Report 1 Sample Company #{@report1.id}")
            expect(page).to have_link("Report 3 Sample Company #{@report3.id}")
            expect(page).to have_link("Report 4 Sample Company #{@report4.id}")
            expect(page).to have_link("Report 8 Sample Company #{@report8.id}")
          end
        end
      end

      it "shows all of the completed reports" do
        visit reports_path

        within(".reports") do
          within(".closed") do
            expect(page).to have_link("Report 2 Sample Company #{@report2.id}")
            expect(page).to have_link("Report 5 Sample Company #{@report5.id}")
            expect(page).to have_link("Report 6 Sample Company #{@report6.id}")
            expect(page).to have_link("Report 7 Sample Company #{@report7.id}")
          end
        end
      end

      it "redirects the user to the associated report show page when a link is cliked" do
        visit reports_path

        click_link("Report 1 Sample Company #{@report1.id}")

        expect(current_path).to eq(report_path(@report1))
      end

      it "has a log-out button"
      it "logs out the user when the log-out button is clicked"
      it "has a link to create a new report"
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the reports index page it" do
      it "redirects to the login page"
    end
  end
end
