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

      @book_1 = Book.create!(title: "Mustache City", pages: 450, year: 2017)
      @book_2 = Book.create!(title: "Starbucks Hacks: Cheap Drinks That Taste Expensive", pages: 10, year: 2015)

      @review_1 = @book_1.reviews.create!(title: "Review 1 Title", text: "Review 1 Text", rating: 5, user: @user_1)
      @review_2 = @book_2.reviews.create!(title: "Review 2 Title", text: "Review 2 Text", rating: 2, user: @user_1)
    end

    it ".review_count" do
      expect(@user_1.review_count).to eq(2)
    end
  end
end
