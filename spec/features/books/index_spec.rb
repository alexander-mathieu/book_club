require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit /books' do
    before :each do
      @book_1 = Book.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = Book.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = Book.create!(title: "Trip to Mars", pages: 480, year: 2020)
    end

    it 'I see all book titles in the database' do
      visit '/books'

      within("#book-#{@book_1.id}") do
        expect(page).to have_css("img[src='#{@book_1.image}']")
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.year)
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_css("img[src='#{@book_2.image}']")
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.pages)
        expect(page).to have_content(@book_2.year)
      end

      within("#book-#{@book_3.id}") do
        expect(page).to have_css("img[src='#{@book_3.image}']")
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(@book_3.pages)
        expect(page).to have_content(@book_3.year)
      end
    end
  end
end
