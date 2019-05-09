require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit a book's show page" do
    before :each do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")

      @author_1 = Author.create!(name: "Brennan Ayers")
      @author_2 = Author.create!(name: "John Flapjacks")
      @author_3 = Author.create!(name: "Patrick Duvall, M.D.")
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

    it "it displays information about a single book" do
      visit book_path(@book_1)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content("Author(s): #{@author_1.name}, #{@author_4.name}")
      expect(page).to have_content("Pages: #{@book_1.pages}")
      expect(page).to have_content("Published: #{@book_1.year}")
      expect(page).to have_css("img[src='#{@book_1.image}']")
    end

    it "it does not display information about other books" do
      visit book_path(@book_1)

      expect(page).to_not have_content(@book_2.title)
      expect(page).to_not have_content("Author(s): #{@author_2.name}")
      expect(page).to_not have_content("Pages: #{@book_2.pages}")
      expect(page).to_not have_content("Published: #{@book_2.year}")
      # expect(page).to_not have_css("img[src='#{@book_2.image}']")
    end
  end
end
