require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit an Authors show page' do
    before :each do
      @flapjacks = Author.create!(name: "Johnny Flapjacks")
      @cheese = Author.create!(name: "Vincenzo 'Big' Cheese")

      @book_1 = @flapjacks.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @flapjacks.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = @flapjacks.books.create!(title: "Trip to Mars", pages: 480, year: 2020)
      @book_1.authors << @cheese
    end

    it 'I should be able to see all books and their information by that author' do
      visit author_path(@flapjacks)

      expect(page).to have_content(@flapjacks.name)

      within("#book-#{@book_1.id}-info") do
        expect(page).to have_css("src=#{@book_1.image}")
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Published: #{@book_1.year}")
      end

      within("#book-#{@book_2.id}-info") do
        expect(page).to have_css("src=#{@book_2.image}")
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content("Pages: #{@book_2.pages}")
        expect(page).to have_content("Published: #{@book_2.year}")
      end

      within("#book-#{@book_3.id}-info") do
        expect(page).to have_css("src=#{@book_3.image}")
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content("Pages: #{@book_3.pages}")
        expect(page).to have_content("Published: #{@book_3.year}")
      end
    end
  end
end
