require 'rails_helper'

RSpec.describe "Reports index page" do
  before :each do
    @report1 = Report.create!(name: "Report 1", company: "Sample Company")
    @report2 = Report.create!(name: "Report 2", company: "Sample Company", status: 5)
    @report3 = Report.create!(name: "Report 3", company: "Sample Company")
    @user = User.create!(name: "Name1", email: "email@domain.com")
  end

  describe "Happy Path" do
    describe "when a logged in user visits the reports index page it" do
      before :each do
        visit root_path
        fill_in :email, with: @user.email
        click_button :login
      end

      it "shows all of the current reports" do
        visit reports_path

        within(".reports") do
          within(".open") do
            expect(page).to have_link("Report 1 Sample Company #{@report1.id}")
            expect(page).to have_link("Report 3 Sample Company #{@report3.id}")
          end
        end
      end

      it "shows all of the completed reports" do
        visit reports_path

        within(".reports") do
          within(".closed") do
            expect(page).to have_link("Report 2 Sample Company #{@report2.id}")
          end
        end
      end

      it "redirects the user to the associated report show page when a link is cliked" do
        visit reports_path
        click_link("Report 1 Sample Company #{@report1.id}")

        expect(current_path).to eq(report_path(@report1))
      end

      it "has a link to create a new report"

      it "redirects the user to the report new page when the link is cliked"

      it "has a log-out button" do
        visit reports_path

        expect(page).to have_button("Logout")
      end

      it "logs out the user when the log-out button is clicked" do
        visit reports_path

        click_button "Logout"

        expect(current_path).to eq(root_path)
        expect(page).to have_content("You have been logged out.")

        visit reports_path
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end

  describe "Sad Path" do
    describe "when a loged out user visits the reports index page it" do
      it "redirects to the login page" do
        visit reports_path
        expect(current_path).to eq(root_path)
        expect(page).to have_content("Sorry, your credentials are bad.")
      end
    end
  end
end
