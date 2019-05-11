require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit the Authors index' do
    before :each do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")

      @author_1 = Author.create!(name: "Brennan Ayers")
      @author_2 = Author.create!(name: "John Flapjacks")
      @author_3 = Author.create!(name: "Patrick Duvall")
      @author_4 = Author.create!(name: "Alexander Mathieu")

      @book_1 = @author_1.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @author_2.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = @author_3.books.create!(title: "Trip to Mars", pages: 480, year: 2020)
      @book_1.authors << @author_4

      @review_1 = @book_1.reviews.create!(text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(text: "This book didn't do it for me.", rating: 3, user: @user_2)
      @review_3 = @book_2.reviews.create!(text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_3.reviews.create!(text: "This book went to the market!", rating: 3, user: @user_2)
    end

    it 'I should see all Authors in the database' do
      visit authors_path

      expect(page).to have_content("Author's Lounge")

      within("#author-#{@author_1.id}-info") do
        expect(page).to have_css("img[src='#{@author_1.image}']")
        expect(page).to have_link("#{@author_1.name}")
        expect(page).to have_content("#Books: #{@book_1.title}")
        expect(page).to have_content("#Number of Books: #{@author_1.book_count}")
      end

      within("#author-#{@author_2.id}-info") do
        expect(page).to have_css("img[src='#{@author_2.image}']")
        expect(page).to have_link("#{@author_2.name}")
        expect(page).to have_content("Books: #{@book_2.title}")
        expect(page).to have_content("Number of Books: #{@author_2.book_count}")
      end

      within("#author-#{@author_3.id}-info") do
        expect(page).to have_css("img[src='#{@author_3.image}']")
        expect(page).to have_link("#{@author_3.name}")
        expect(page).to have_content("Books: #{@book_3.title}")
        expect(page).to have_content("Number of Books: #{@author_3.book_count}")
      end

      within("#author-#{@author_4.id}-info") do
        expect(page).to have_css("img[src='#{@author_4.image}']")
        expect(page).to have_link("#{@author_4.name}")
        expect(page).to have_content("Books: #{@book_1.title}")
        expect(page).to have_content("Number of Books: #{@author_4.book_count}")
      end
    end
  end
end
