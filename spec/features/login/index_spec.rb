require 'rails_helper'

RSpec.describe "Login Index page" do
  describe "happy path" do
    it "has a button to log in via microsoft_office365" do
      visit root_path

      expect(page).to have_button("Login")
    end
  end
end
