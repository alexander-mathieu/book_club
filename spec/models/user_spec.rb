require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many :reviews}
  end

  describe "instance methods" do
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
      @book_4 = @author_1.books.create!(title: "Mustache City", pages: 450, year: 2017)
      @book_5 = @author_3.books.create!(title: "Starbucks Hacks: Cheap Drinks That Taste Expensive", pages: 10, year: 2015)
      @book_6 = @author_4.books.create!(title: "The Hardest Way to Earn an Easy Living", pages: 1000, year: 2019)
      @book_1.authors << @author_4
      @book_4.authors << @author_2

      @review_1 = @book_1.reviews.create!(title: "Review Title 1", text: "Review 1 Text", rating: 1, user: @user_1)
      @review_2 = @book_1.reviews.create!(title: "Review Title 2", text: "Review 2 Text", rating: 2, user: @user_2)
      @review_3 = @book_1.reviews.create!(title: "Review Title 3", text: "Review 3 Text", rating: 3, user: @user_3)
      @review_4 = @book_1.reviews.create!(title: "Review Title 4", text: "Review 4 Text", rating: 4, user: @user_4)
      @review_5 = @book_1.reviews.create!(title: "Review Title 5", text: "Review 5 Text", rating: 5, user: @user_5)
      @review_6 = @book_1.reviews.create!(title: "Review Title 6", text: "Review 6 Text", rating: 1, user: @user_6)
      @review_7 = @book_2.reviews.create!(title: "Review Title 7", text: "Review 7 Text", rating: 2, user: @user_1)
      @review_8 = @book_2.reviews.create!(title: "Review Title 8", text: "Review 8 Text", rating: 3, user: @user_2)
      @review_9 = @book_2.reviews.create!(title: "Review Title 9", text: "Review 9 Text", rating: 4, user: @user_3)
      @review_10 = @book_2.reviews.create!(title: "Review Title 10", text: "Review 10 Text", rating: 5, user: @user_4)
      @review_11 = @book_3.reviews.create!(title: "Review Title 11", text: "Review 11 Text", rating: 1, user: @user_1)
      @review_12 = @book_3.reviews.create!(title: "Review Title 12", text: "Review 12 Text", rating: 2, user: @user_2)
      @review_13 = @book_3.reviews.create!(title: "Review Title 13", text: "Review 13 Text", rating: 3, user: @user_3)
      @review_14 = @book_3.reviews.create!(title: "Review Title 14", text: "Review 14 Text", rating: 4, user: @user_4)
      @review_15 = @book_4.reviews.create!(title: "Review Title 15", text: "Review 15 Text", rating: 5, user: @user_1)
      @review_16 = @book_4.reviews.create!(title: "Review Title 16", text: "Review 16 Text", rating: 1, user: @user_2)
      @review_17 = @book_5.reviews.create!(title: "Review Title 17", text: "Review 17 Text", rating: 2, user: @user_1)
      @review_18 = @book_6.reviews.create!(title: "Review Title 18", text: "Review 18 Text", rating: 3, user: @user_2)
    end

    it "#review_count" do
      expect(@user_1.review_count).to eq(5)
    end
  end

  describe "class methods" do
    it ".top_three_users" do
      expect(User.top_three_users).to eq(@user_1, @user_2, @user_3)
    end
  end
end
