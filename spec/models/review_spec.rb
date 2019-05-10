require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "validations" do
    it {should validate_presence_of :text}
    it {should validate_presence_of :rating}
  end

  describe "relationships" do
    it {should belong_to :user}
    it {should belong_to :book}
  end

  describe "instance methods" do
    before :each do
      travel_to Time.zone.local(2019, 05, 10, 12, 00, 00)

      @user = User.create!(name: "Anony-moose")

      @author_1 = Author.create!(name: "John Flapjacks")

      @book_1 = @author_1.books.create!(title: "Veronica Mars", pages: 10, year: 2012)

      @review_1 = @book_1.reviews.create!(title: "Wow!", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user)
    end

    it '.date' do
      expect(@review_1.date).to eq("10 May 2019")
    end
  end

  describe 'class methods' do
    before :each do
      @user = User.create!(name: "Anony-moose")

      @author_1 = Author.create!(name: "John Flapjacks")

      @book_1 = @author_1.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @author_1.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = @author_1.books.create!(title: "Trip to Mars", pages: 480, year: 2020)

      travel_to Time.zone.local(2019, 05, 10, 18, 00, 00)
      @review_1 = @book_1.reviews.create!(title: "Wow!", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user)

      travel_to Time.zone.local(2019, 05, 10, 10, 00, 00)
      @review_2 = @book_2.reviews.create!(title: "Disappointing...", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user)

      travel_to Time.zone.local(2019, 05, 11, 18, 00, 00)
      @review_3 = @book_3.reviews.create!(title: "All the way home!", text: "This book went to the market!", rating: 3, user: @user)
    end

    it '.sort_by_date' do
      expect(Review.sort_by_date("newest")).to eq([@review_3, @review_1, @review_2])
      expect(Review.sort_by_date("oldest")).to eq([@review_2, @review_1, @review_3])
    end
  end
end
