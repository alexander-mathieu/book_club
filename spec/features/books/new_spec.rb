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

    it "I see a link to navigate back to book index" do
      visit new_book_path

      expect(page).to have_content("<< Return to All Books")
    end

    describe "and click '<< Return to All Books'" do
      it "I'm taken back to the book index" do

      visit new_book_path

      click_link "<< Return to All Books"

      expect(current_path).to eq(books_path)
      end
    end

    describe "and click 'Add Book'" do
      it "I'm taken to the new book's show page" do
        visit new_book_path

        fill_in "Title:", with: "A Treatise on Dressing Casually"
        fill_in "Number of Pages:", with: 800
        fill_in "Year Published:", with: 2019
        fill_in "Author(s):", with: "Zachary Livingston, Jordie George"

        click_button "Add Book"

        book = Book.last

        expect(current_path).to eq(book_path(book))
      end

      it "I'm notified that the book was added successfully" do
        visit new_book_path

        fill_in "Title:", with: "A Treatise on Dressing Casually"
        fill_in "Number of Pages:", with: 800
        fill_in "Year Published:", with: 2019
        fill_in "Author(s):", with: "Zachary Livingston, Jordie George"

        click_button "Add Book"

        book = Book.last

        expect(page).to have_content("'#{book.title}' was added.")
      end
    end

    describe "and try to add a book that is already in the database" do
      it "I'm notified that adding the book was unsuccessful" do
        Book.create!(title: "Trip to Mars", pages: 480, year: 2020)

        visit new_book_path

        fill_in "Title:", with: "Trip to Mars"
        fill_in "Number of Pages:", with: 480
        fill_in "Year Published:", with: 2020
        fill_in "Author(s):", with: "Patrick Duvall"

        click_button "Add Book"

        expect(page).to have_content("Looks like that title is already in the nook!")
      end
    end
  end
end
