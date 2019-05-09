require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit the new book page" do
    it "I see a form to create a new book" do
      visit new_book_path

      within("#new-book-form") do
        expect(page).to have_field("Title:")
        expect(page).to have_field("Number of Pages:")
        expect(page).to have_field("Year Published:")
        expect(page).to have_field("Author(s):")
        expect(page).to have_field("Image URL:")
      end
    end
  end
end
