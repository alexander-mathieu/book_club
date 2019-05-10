require 'rails_helper'

RSpec.describe "As a user", type: :feature do
  describe "When I visit /books" do
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

    it "I see all book titles in the database" do
      visit books_path

      within("#book-#{@book_1.id}") do
        expect(page).to have_css("img[src='#{@book_1.image}']")

        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.authors[0].name)
        expect(page).to have_content(@book_1.authors[1].name)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.year)
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_css("img[src='#{@book_2.image}']")

        expect(page).to have_content(@book_2.title)
        expect(page).to have_content(@book_2.authors[0].name)
        expect(page).to have_content(@book_2.pages)
        expect(page).to have_content(@book_2.year)
      end

      within("#book-#{@book_3.id}") do
        expect(page).to have_css("img[src='#{@book_3.image}']")

        expect(page).to have_content(@book_3.title)
        expect(page).to have_content(@book_3.authors[0].name)
        expect(page).to have_content(@book_3.pages)
        expect(page).to have_content(@book_3.year)
      end
    end

    it "I see an average review rating and amount of reviews on each book" do
      visit books_path

      within("#book-#{@book_1.id}") do
        expect(page).to have_content("Average Rating: 4.0 (2)")
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_content("Average Rating: 2.0 (1)")
      end

      within("#book-#{@book_3.id}") do
        expect(page).to have_content("Average Rating: 3.0 (1)")
      end
    end

    it "I see a link to create a new book" do
      visit books_path

      expect(page).to have_link("Add a New Book")
    end

    it "I'm able to navigate to a new book form" do
      visit books_path
      
      click_link "Add a New Book"

      expect(current_path).to eq(new_book_path)
    end

    describe "I see sorting methods" do
      it "to sort by average rating" do
        visit books_path

        click_link 'Sort by: Lowest Rating'

        expect(@book_2.title).to appear_before(@book_3.title)
        expect(@book_3.title).to appear_before(@book_1.title)

        click_link 'Sort by: Highest Rating'

        expect(@book_1.title).to appear_before(@book_3.title)
        expect(@book_3.title).to appear_before(@book_2.title)
      end

      it "to sorts by number of pages" do
        visit books_path

        click_link 'Sort by: Most Pages'

        expect(@book_3.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_1.title)

        click_link 'Sort by: Least Pages'

        expect(@book_1.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_3.title)
      end

      it "to sorts by number of reviews" do
        review_5 = @book_2.reviews.create!(text: "THIS BOOK IS!", rating: 5, user: @user_1)
        review_6 = @book_1.reviews.create!(text: "BOOK!", rating: 5, user: @user_2)
        visit books_path

        click_link 'Sort by: Most Reviews'

        expect(@book_1.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_3.title)

        click_link 'Sort by: Least Reviews'

        expect(@book_3.title).to appear_before(@book_2.title)
        expect(@book_3.title).to appear_before(@book_1.title)
      end
    end
  end
end
