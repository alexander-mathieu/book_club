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

      @review_1 = @book_1.reviews.create!(title: "WOW!", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "WHY?", text: "This book didn't do it for me.", rating: 3, user: @user_2)
      @review_3 = @book_2.reviews.create!(title: "HOW?", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_3.reviews.create!(title: "WEE!", text: "This book went to the market!", rating: 3, user: @user_2)
    end

    it "I see a navigation bar" do
      visit books_path

      within("#nav") do
        expect(page).to have_link("Home")
        expect(page).to have_link("Browse by Author")
        expect(page).to have_link("Browse by Book")
      end
    end

    it "I'm able to use the navigation bar to navigate'" do
      visit books_path

      click_link "Browse by Author"

      expect(current_path).to eq(authors_path)

      click_link "Browse by Book"

      expect(current_path).to eq(books_path)

      click_link "Home"

      expect(current_path).to eq(root_path)
    end

    it "I see all book titles in the database" do
      visit books_path

      within("#book-#{@book_1.id}") do
        expect(page).to have_css("img[src='#{@book_1.image}']")

        expect(page).to have_content(@book_1.title)
        expect(page).to have_link(@book_1.authors[0].name)
        expect(page).to have_link(@book_1.authors[1].name)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.year)
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_css("img[src='#{@book_2.image}']")

        expect(page).to have_content(@book_2.title)
        expect(page).to have_link(@book_2.authors[0].name)
        expect(page).to have_content(@book_2.pages)
        expect(page).to have_content(@book_2.year)
      end

      within("#book-#{@book_3.id}") do
        expect(page).to have_css("img[src='#{@book_3.image}']")

        expect(page).to have_content(@book_3.title)
        expect(page).to have_link(@book_3.authors[0].name)
        expect(page).to have_content(@book_3.pages)
        expect(page).to have_content(@book_3.year)
      end
    end

    it "I see that each book title is a link" do
      visit books_path

      within("#book-#{@book_1.id}") do
        expect(page).to have_link(@book_1.title)
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_link(@book_2.title)
      end

      within("#book-#{@book_3.id}") do
        expect(page).to have_link(@book_3.title)
      end
    end

    it "I'm able to navigate to a book's show page by clicking the title" do
      visit books_path

      within("#book-#{@book_1.id}") do
        click_link @book_1.title
      end

      expect(current_path).to eq(book_path(@book_1))
    end

    it "I see an average review rating and amount of reviews on each book" do
      visit books_path

      within("#book-#{@book_1.id}") do
        expect(page).to have_content("Average Rating: 3.0 (6)")
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_content("Average Rating: 2.5 (4)")
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

    describe "and look at the book statistics section"
      before :each do
        @user_3 = User.create!(name: "LogyBear")
        @user_4 = User.create!(name: "MILLS")
        @user_5 = User.create!(name: "DocPat")
        @user_6 = User.create!(name: "BilhamTheConqueror")

        @book_4 = Book.create!(title: "Mustache City", pages: 450, year: 2017)
        @book_5 = Book.create!(title: "Starbucks Hacks: Cheap Drinks That Taste Expensive", pages: 10, year: 2015)
        @book_6 = Book.create!(title: "The Hardest Way to Earn an Easy Living", pages: 1000, year: 2019)
        @book_4.authors << [@author_1, @author_2]
        @book_5.authors << @author_3
        @book_6.authors << @author_4

        @review_5 = @book_1.reviews.create!(title: "Review Title 5", text: "Review 5 Text", rating: 1, user: @user_3)
        @review_6 = @book_1.reviews.create!(title: "Review Title 6", text: "Review 6 Text", rating: 2, user: @user_4)
        @review_7 = @book_1.reviews.create!(title: "Review Title 7", text: "Review 7 Text", rating: 3, user: @user_5)
        @review_8 = @book_1.reviews.create!(title: "Review Title 8", text: "Review 8 Text", rating: 4, user: @user_6)
        @review_9 = @book_2.reviews.create!(title: "Review Title 9", text: "Review 9 Text", rating: 5, user: @user_1)
        @review_10 = @book_2.reviews.create!(title: "Review Title 10", text: "Review 10 Text", rating: 1, user: @user_3)
        @review_11 = @book_2.reviews.create!(title: "Review Title 11", text: "Review 11 Text", rating: 2, user: @user_4)
        @review_12 = @book_3.reviews.create!(title: "Review Title 12", text: "Review 12 Text", rating: 3, user: @user_5)
        @review_13 = @book_3.reviews.create!(title: "Review Title 13", text: "Review 13 Text", rating: 4, user: @user_2)
        @review_14 = @book_3.reviews.create!(title: "Review Title 14", text: "Review 14 Text", rating: 5, user: @user_3)
        @review_15 = @book_4.reviews.create!(title: "Review Title 15", text: "Review 15 Text", rating: 1, user: @user_1)
        @review_16 = @book_4.reviews.create!(title: "Review Title 16", text: "Review 16 Text", rating: 2, user: @user_2)
        @review_17 = @book_5.reviews.create!(title: "Review Title 17", text: "Review 17 Text", rating: 5, user: @user_1)
        @review_18 = @book_6.reviews.create!(title: "Review Title 18", text: "Review 18 Text", rating: 4, user: @user_2)
      end

      it "I see the three highest rated books" do
        visit books_path

        within "#book-stats" do
          within "#highest-rated" do
            expect(page).to have_link(@book_5.title)
            expect(page).to have_content(@book_5.average_rating)

            expect(page).to have_link(@book_6.title)
            expect(page).to have_content(@book_6.average_rating)

            expect(page).to have_link(@book_3.title)
            expect(page).to have_content(@book_3.average_rating)
          end
        end
      end

      it "I see the three lowest rated books" do
        visit books_path

        within "#book-stats" do
          within "#lowest-rated" do
            expect(page).to have_link(@book_4.title)
            expect(page).to have_content(@book_4.average_rating)

            expect(page).to have_link(@book_1.title)
            expect(page).to have_content(@book_1.average_rating)

            expect(page).to have_link(@book_2.title)
            expect(page).to have_content(@book_2.average_rating)
          end
        end
      end

      it "I see the three users that have written the most reviews" do
        visit books_path

        within "#book-stats" do
          within "#user-stats" do
            expect(page).to have_link(@user_1.name)
            expect(page).to have_content(@user_1.review_count)

            expect(page).to have_link(@user_2.name)
            expect(page).to have_content(@user_2.review_count)

            expect(page).to have_link(@user_3.name)
            expect(page).to have_content(@user_3.review_count)
          end
        end
      end

    describe "I see sorting methods" do
      it "to sort by average rating" do
        visit books_path

        click_link 'Sort by: Lowest Rating'

        expect(@book_4.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_1.title)
        expect(@book_1.title).to appear_before(@book_3.title)
        expect(@book_3.title).to appear_before(@book_6.title)
        expect(@book_6.title).to appear_before(@book_5.title)

        click_link 'Sort by: Highest Rating'

        expect(@book_5.title).to appear_before(@book_6.title)
        expect(@book_6.title).to appear_before(@book_3.title)
        expect(@book_3.title).to appear_before(@book_1.title)
        expect(@book_1.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_4.title)
      end

      it "to sort by number of pages" do
        visit books_path

        click_link 'Sort by: Most Pages'

        expect(@book_3.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_1.title)

        click_link 'Sort by: Least Pages'

        expect(@book_1.title).to appear_before(@book_2.title)
        expect(@book_2.title).to appear_before(@book_3.title)
      end

      it "to sort by number of reviews" do
        @review_5 = @book_2.reviews.create!(title: "HOLY", text: "THIS BOOK IS!", rating: 5, user: @user_1)
        @review_6 = @book_1.reviews.create!(title: "MOLY", text: "BOOK!", rating: 5, user: @user_2)
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
