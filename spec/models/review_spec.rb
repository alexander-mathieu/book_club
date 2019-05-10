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
end
