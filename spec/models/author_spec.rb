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
  end
end
