require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit the new book page" do
    it "I see a form to create a new book" do
      visit new_book_path

      within("#new-book-form") do
        expect(page).to have_content("Book Title:")
        # expect(page).to have_field()
        expect(page).to have_content("Number of Pages:")
        # expect(page).to have_field()
        expect(page).to have_content("Year Published:")
        # expect(page).to have_field()
        expect(page).to have_content("Book Author(s):")
        # expect(page).to have_field()
        expect(page).to have_content("Image:")
        # expect(page).to have_field()
      end
    end
  end
end
