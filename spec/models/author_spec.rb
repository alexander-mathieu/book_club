require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end

  describe "relationships" do
    it {should have_many(:books).through(:books_by_author)}
  end

  describe 'instance methods' do
    before :each do
      @flapjacks = Author.create!(name: "John Flapjacks")

      @book_1 = @flapjacks.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @flapjacks.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
    end

    it '#book_count' do
      expect(@flapjacks.book_count).to eq(2)
    end

    it '#top_three_books' do
      @book_3 = @flapjacks.books.create!(title: "Willkommen im Dschungel", pages: 967, year: 1983)
      @book_4 = @flapjacks.books.create!(title: "My Life: A Journey", pages: 4, year: 2019)

      @user_1 = User.create!(name: "Anony-moose")
      @user_2 = User.create!(name: "VinnyCheese")

      @review_2 = @book_1.reviews.create!(title: "Boring", text: "This book didn't do it for me.", rating: 3, user: @user_2)
      @review_3 = @book_2.reviews.create!(title: "Droning", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user_1)
      @review_4 = @book_3.reviews.create!(title: "Going", text: "This book went to the market!", rating: 3, user: @user_2)
      @review_5 = @book_3.reviews.create!(title: "Not Very Good", text: "I expected more from this author.", rating: 3, user: @user_2)
      @review_6 = @book_4.reviews.create!(title: "Don't Know What to Say", text: "Pretty alright.", rating: 4, user: @user_1)
      @review_7 = @book_4.reviews.create!(title: "Speechless", text: "This book totally blew me away.", rating: 5, user: @user_2)
      @review_8 = @book_1.reviews.create!(title: "This Book Blows", text: "This book should get blown away.", rating: 2, user: @user_1)

      expect(@flapjacks.top_three_books).to eq([@book_4, @book_3, @book_1])
    end
  end
end
