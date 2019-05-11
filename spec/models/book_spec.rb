require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'validations' do
    it { should validate_presence_of :title}
    it { should validate_presence_of :pages}
    it { should validate_presence_of :year}
  end

  describe "relationships" do
    it {should have_many :reviews}
    it {should have_many(:authors).through(:books_by_author)}
  end

  describe "instance methods" do
    before(:each) do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")
      @user_3 = User.create!(name: "LogyBear")
      @user_4 = User.create!(name: "MILLS")
      @user_5 = User.create!(name: "DocPat")
      @user_6 = User.create!(name: "BilhamTheConqueror")

      @author_1 = Author.create!(name: "Jim")
      @author_2 = Author.create!(name: "Bob")

      @book_1 = @author_1.books.create!(title: "The Adventure", pages: 1, year: 1985)
      @book_2 = @author_2.books.create!(title: "Smithsonian Fun", pages: 4, year: 2017)
      @book_1.authors << @author_2

      @review_1 = @book_1.reviews.create!(text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(text: "This book didn't do it for me.", rating: 1, user: @user_2)
      @review_3 = @book_2.reviews.create!(text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_1.reviews.create!(title: "Not Very Good", text: "I expected more from this author.", rating: 2, user: @user_3)
      @review_5 = @book_1.reviews.create!(title: "Don't Know What to Say", text: "Pretty alright.", rating: 4, user: @user_4)
      @review_6 = @book_1.reviews.create!(title: "Speechless", text: "This book totally blew me away.", rating: 5, user: @user_5)
      @review_7 = @book_1.reviews.create!(title: "This Book Blows", text: "This book should get blown away.", rating: 1, user: @user_6)
    end

    it "#author_names" do
      expect(@book_1.author_names).to eq(["Jim", "Bob"])
      expect(@book_2.author_names).to eq(["Bob"])
    end

    it "#average_rating" do
      expect(@book_1.average_rating).to eq(3.0)
      expect(@book_2.average_rating).to eq(2.0)
    end

    it "#review_count" do
      expect(@book_1.review_count).to eq(6)
      expect(@book_2.review_count).to eq(1)
    end


    it "#highest_three_reviews" do
      expect(@book_1.highest_three_reviews).to eq([@review_1, @review_6, @review_5])
    end

    it "#lowest_three_reviews" do
      expect(@book_1.lowest_three_reviews).to eq([@review_2, @review_7, @review_4])
    end

    it "#coauthors" do
      expect(@book_1.coauthors(@author_1)).to eq(["Bob"])
      expect(@book_1.coauthors(@author_2)).to eq(["Jim"])
    end
  end

  describe 'class methods' do
    before :each do
      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")

      @author_1 = Author.create!(name: "Jim")
      @author_2 = Author.create!(name: "Bob")

      @book_1 = @author_1.books.create!(title: "The Adventure", pages: 1, year: 1985)
      @book_2 = @author_2.books.create!(title: "Smithsonian Fun", pages: 4, year: 2017)
      @book_3 = @author_2.books.create!(title: "Trip to Mars", pages: 480, year: 2020)
      @book_1.authors << @author_2

      @review_1 = @book_1.reviews.create!(title: "WOW", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "Meh", text: "This book didn't do it for me.", rating: 3, user: @user_2)
      @review_3 = @book_2.reviews.create!(title: "A Bit Disappointed", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_3.reviews.create!(title: "This Little Book Stayed Home", text: "This book went to the market!", rating: 3, user: @user_2)
    end

    it '.ratings_sort' do
      expect(Book.ratings_sort(:asc)).to eq([@book_2, @book_3, @book_1])
      expect(Book.ratings_sort(:desc)).to eq([@book_1, @book_3, @book_2])
    end

    it '.ratings_sort with a book with no rating' do
      book_4 = @author_1.books.create!(title: "No Reviews", pages: 1500, year: 1900)

      expect(Book.ratings_sort(:asc)).to eq([book_4, @book_2, @book_3, @book_1])
      expect(Book.ratings_sort(:desc)).to eq([@book_1, @book_3, @book_2, book_4])
    end

    it '.pages_sort' do
      expect(Book.pages_sort(:asc)).to eq([@book_1, @book_2, @book_3])
      expect(Book.pages_sort(:desc)).to eq([@book_3, @book_2, @book_1])
    end

    it '.reviews_sort' do
      review_5 = @book_2.reviews.create!(text: "THIS BOOK IS!", rating: 5, user: @user_1)
      review_6 = @book_1.reviews.create!(text: "BOOK!", rating: 5, user: @user_2)

      expect(Book.reviews_sort(:desc)).to eq([@book_1, @book_2, @book_3])
      expect(Book.reviews_sort(:asc)).to eq([@book_3, @book_2, @book_1])
    end

    it '.reviews_sort with one book with no review' do
      review_5 = @book_2.reviews.create!(text: "THIS BOOK IS!", rating: 5, user: @user_1)
      review_6 = @book_1.reviews.create!(text: "BOOK!", rating: 5, user: @user_2)
      book_4 = @author_1.books.create!(title: "No Reviews", pages: 1500, year: 1900)

      expect(Book.reviews_sort(:desc)).to eq([@book_1, @book_2, @book_3, book_4])
      expect(Book.reviews_sort(:asc)).to eq([book_4, @book_3, @book_2, @book_1])
    end
  end
end
