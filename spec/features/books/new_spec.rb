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

        expect(page).to have_button("Add Book")
      end
    end

    it "and click 'Add Book', I'm taken to the new book's show page" do
      visit new_book_path

      fill_in "Title:", with: "A Treatise on Dressing Casually"
      fill_in "Number of Pages:", with: 800
      fill_in "Year Published:", with: 2019
      fill_in "Author(s):", with: "Zachary Livingston"

      click_button "Add Book"

      book = Book.last

      expect(current_path).to eq(book_path(book))
    end

    it "I see a link to navigate back to book index" do
      visit new_book_path

      expect(page).to have_content("<< Return to All Books")
    end

    it "and click '<< Return to All Books', I'm taken back to the book index" do
      visit new_book_path

      click_link "<< Return to All Books"

      expect(current_path).to eq(books_path)
    end
  end
end
