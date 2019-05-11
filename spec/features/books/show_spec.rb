require 'rails_helper'

RSpec.describe "as a user" do
  describe "when I visit a book's show page" do
    before :each do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")
      @user_3 = User.create!(name: "LogyBear")
      @user_4 = User.create!(name: "MILLS")
      @user_5 = User.create!(name: "DocPat")
      @user_6 = User.create!(name: "BilhamTheConqueror")

      @author_1 = Author.create!(name: "Brennan Ayers")
      @author_2 = Author.create!(name: "John Flapjacks")
      @author_3 = Author.create!(name: "Patrick Duvall, M.D.")
      @author_4 = Author.create!(name: "Alexander Mathieu")

      @book_1 = @author_1.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @author_2.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = @author_3.books.create!(title: "Trip to Mars", pages: 480, year: 2020)
      @book_1.authors << @author_4

      @review_1 = @book_1.reviews.create!(title: "WOW", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "Meh", text: "This book didn't do it for me.", rating: 3, user: @user_2)
      @review_3 = @book_2.reviews.create!(title: "A Bit Disappointed", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_3.reviews.create!(title: "This Little Book Stayed Home", text: "This book went to the market!", rating: 3, user: @user_2)
      @review_5 = @book_1.reviews.create!(title: "Not Very Good", text: "I expected more from this author.", rating: 2, user: @user_3)
      @review_6 = @book_1.reviews.create!(title: "Don't Know What to Say", text: "Pretty alright.", rating: 4, user: @user_4)
      @review_7 = @book_1.reviews.create!(title: "Speechless", text: "This book totally blew me away.", rating: 5, user: @user_5)
      @review_8 = @book_1.reviews.create!(title: "This Book Blows", text: "This book should get blown away.", rating: 1, user: @user_6)
    end

    it "it displays information about a single book" do
      visit book_path(@book_1)

      expect(page).to have_content(@book_1.title)
      expect(page).to have_css("img[src='#{@book_1.image}']")

      within("#book-#{@book_1.id}-info") do
        expect(page).to have_link("#{@author_1.name}")
        expect(page).to have_link("#{@author_4.name}")
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Published: #{@book_1.year}")
      end
    end

    it "it does not display information about other books" do
      visit book_path(@book_1)

      expect(page).to_not have_content(@book_2.title)
      expect(page).to_not have_link("#{@author_2.name}")
      expect(page).to_not have_content("Pages: #{@book_2.pages}")
      expect(page).to_not have_content("Published: #{@book_2.year}")
      # expect(page).to_not have_css("img[src='#{@book_2.image}']")
    end

    it "it displays a list of reviews for a single book" do
      visit book_path(@book_1)

      within(".all-reviews") do
        within("#review-#{@review_1.id}") do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content("#{@user_1.name}, #{@review_1.rating} Stars")
          expect(page).to have_content(@review_1.text)
        end

        within("#review-#{@review_2.id}") do
          expect(page).to have_content(@review_2.title)
          expect(page).to have_content("#{@user_2.name}, #{@review_2.rating} Stars")
          expect(page).to have_content(@review_2.text)
        end

        within("#review-#{@review_5.id}") do
          expect(page).to have_content(@review_5.title)
          expect(page).to have_content("#{@user_3.name}, #{@review_5.rating} Stars")
          expect(page).to have_content(@review_5.text)
        end

        within("#review-#{@review_6.id}") do
          expect(page).to have_content(@review_6.title)
          expect(page).to have_content("#{@user_4.name}, #{@review_6.rating} Stars")
          expect(page).to have_content(@review_6.text)
        end

        within("#review-#{@review_7.id}") do
          expect(page).to have_content(@review_7.title)
          expect(page).to have_content("#{@user_5.name}, #{@review_7.rating} Stars")
          expect(page).to have_content(@review_7.text)
        end

        within("#review-#{@review_8.id}") do
          expect(page).to have_content(@review_8.title)
          expect(page).to have_content("#{@user_6.name}, #{@review_8.rating} Stars")
          expect(page).to have_content(@review_8.text)
        end
      end
    end

    it "it displays a link to delete the book" do
      visit book_path(@book_1)

      expect(page).to have_link("Delete Book")
    end

    it "it displays the top and bottom three reviews for the book" do
      visit book_path(@book_1)

      within "#review-stats" do
        within "#highest-reviews" do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_1.rating)
          expect(page).to have_link(@review_1.user.name)

          expect(page).to have_content(@review_7.title)
          expect(page).to have_content(@review_7.rating)
          expect(page).to have_link(@review_7.user.name)

          expect(page).to have_content(@review_6.title)
          expect(page).to have_content(@review_6.rating)
          expect(page).to have_link(@review_6.user.name)
        end

        within "#lowest-reviews" do
          expect(page).to have_content(@review_2.title)
          expect(page).to have_content(@review_2.rating)
          expect(page).to have_link(@review_2.user.name)

          expect(page).to have_content(@review_5.title)
          expect(page).to have_content(@review_5.rating)
          expect(page).to have_link(@review_5.user.name)

          expect(page).to have_content(@review_8.title)
          expect(page).to have_content(@review_8.rating)
          expect(page).to have_link(@review_8.user.name)
        end
      end
    end

    it "it displays an average rating for the book" do
      visit book_path(@book_1)

      within "#review-stats" do
        expect(page).to have_content(@book_1.average_rating.round(2))
      end
    end

    describe "and click the 'Delete Book' link" do
      it "it displays a confirmation message that the book has been deleted" do
        visit book_path(@book_1)

        click_link "Delete Book"

        expect(page).to have_content("'#{@book_1.title}' was deleted.")
      end

      it "it redirects me to /books" do
        visit book_path(@book_1)

        click_link "Delete Book"

        expect(current_path).to eq(books_path)
      end

      it "I do not see the deleted book on the /books" do
        visit book_path(@book_1)

        click_link "Delete Book"

        expect(page).to_not have_css("#book-#{@book_1.id}")
      end
    end
  end
end
