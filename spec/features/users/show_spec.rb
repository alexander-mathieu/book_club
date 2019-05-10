require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit a Users show page' do
    before :each do
      @user = User.create!(name: "Anony-moose")

      @author_1 = Author.create!(name: "John Flapjacks")

      @book_1 = @author_1.books.create!(title: "Veronica Mars", pages: 10, year: 2012)
      @book_2 = @author_1.books.create!(title: "Mars Aquatic", pages: 120, year: 1964)
      @book_3 = @author_1.books.create!(title: "Trip to Mars", pages: 480, year: 2020)

      @review_1 = @book_1.reviews.create!(title: "Wow!", text: "THIS BOOK IS AWESOME!", rating: 5, user: @user)
      @review_2 = @book_2.reviews.create!(title: "Disappointing...", text: "This book seemed like it was more about drones than Mars.", rating: 2, user: @user)
      @review_3 = @book_3.reviews.create!(title: "All the way home!", text: "This book went to the market!", rating: 3, user: @user)
    end

    it 'I should see all that users reviews' do
      visit user_path(@user)

      expect(page).to have_content("#{@user.name}")

      within("#review-#{@review_1.id}") do
        expect(page).to have_content("#{@review_1.title}")
        expect(page).to have_content("Rating: #{@review_1.rating}")
        expect(page).to have_content("Review: #{@review_1.text}")

        expect(page).to have_content("Book: #{@book_1.title}")
        expect(page).to have_content(@book_1.image)
        expect(page).to have_content("Posted on: #{@review_1.date}")
      end

      within("#review-#{@review_2.id}") do
        expect(page).to have_content("#{@review_2.title}")
        expect(page).to have_content("Rating: #{@review_2.rating}")
        expect(page).to have_content("Review: #{@review_2.text}")

        expect(page).to have_content("Book: #{@book_2.title}")
        expect(page).to have_content(@book_2.image)
        expect(page).to have_content("Posted on: #{@review_2.date}")
      end

      within("#review-#{@review_3.id}") do
        expect(page).to have_content("#{@review_3.title}")
        expect(page).to have_content("Rating: #{@review_3.rating}")
        expect(page).to have_content("Review: #{@review_3.text}")

        expect(page).to have_content("Book: #{@book_3.title}")
        expect(page).to have_content(@book_3.image)
        expect(page).to have_content("Posted on: #{@review_3.date}")
      end
    end
  end
end
