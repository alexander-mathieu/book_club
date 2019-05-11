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
        expect(page).to have_css("img[src='#{@book_1.image}']")
        expect(page).to have_content(@book_1.title)
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Published: #{@book_1.year}")
      end

      within("#book-#{@book_2.id}-info") do
        expect(page).to have_css("img[src='#{@book_2.image}']")
        expect(page).to have_content(@book_2.title)
        expect(page).to have_content("Pages: #{@book_2.pages}")
        expect(page).to have_content("Published: #{@book_2.year}")
      end

      within("#book-#{@book_3.id}-info") do
        expect(page).to have_css("img[src='#{@book_3.image}']")
        expect(page).to have_content(@book_3.title)
        expect(page).to have_content("Pages: #{@book_3.pages}")
        expect(page).to have_content("Published: #{@book_3.year}")
      end
    end

    it 'I should only see other authors listed under books' do
      visit author_path(@flapjacks)

      within("#book-#{@book_1.id}-info") do
        expect(page).to have_link("Vincenzo 'Big' Cheese")
      end

      within("#book-#{@book_2.id}-info") do
        expect(page).to_not have_content("Co-authors:")
      end

      within("#book-#{@book_3.id}-info") do
        expect(page).to_not have_content("Co-authors:")
      end
    end

    it 'I should see the top review for each book' do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheeseFan")

      @review_1 = @book_1.reviews.create!(text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(text: "This book didn't do it for me.", rating: 1, user: @user_2)

      visit author_path(@flapjacks)

      within("#book-#{@book_1.id}-info") do
        expect(page).to have_content(@review_1.title)
        expect(page).to have_content("#{@review_1.rating} Stars")
        expect(page).to have_content("Posted by: #{@review_1.user.name}")
      end
    end

    it "I should see the username associated with the top review as a link" do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheeseFan")

      @review_1 = @book_1.reviews.create!(text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(text: "This book didn't do it for me.", rating: 1, user: @user_2)

      visit author_path(@flapjacks)

      within("#book-#{@book_1.id}-info") do
        expect(page).to have_link(@review_1.user.name)
      end
    end

    it "I'm able to visit the top reviewer's show page by clicking their username" do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheeseFan")

      @review_1 = @book_1.reviews.create!(text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(text: "This book didn't do it for me.", rating: 1, user: @user_2)

      visit author_path(@flapjacks)

      within("#book-#{@book_1.id}-info") do
        click_link @review_1.user.name
      end

      expect(current_path).to eq(user_path(@review_1.user.id))
    end

    describe "and click the 'Delete Author' link" do
      it "it displays a confirmation message that the author has been deleted" do
        visit author_path(@flapjacks)

        click_link "Delete Author"

        expect(page).to have_content("'#{@flapjacks.name}' was deleted.")
      end

      it "it redirects me to /books" do
        visit author_path(@flapjacks)

        click_link "Delete Author"

        expect(current_path).to eq(books_path)
      end

      it "I do not see the deleted author on the /books" do
        visit author_path(@flapjacks)

        click_link "Delete Author"

        within("#book-stats") do
          expect(page).to_not have_content(@flapjacks.name)
        end

        within("#all-books") do
          expect(page).to_not have_content(@flapjacks.name)
        end
      end

      it 'also deletes all books attached to this author' do
        visit author_path(@flapjacks)

        click_link "Delete Author"

        @flapjacks.books.each do |book|
          expect(page).to_not have_css("#book-#{book.id}")
        end
      end
    end
  end
end
