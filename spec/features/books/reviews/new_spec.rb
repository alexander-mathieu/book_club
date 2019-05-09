require 'rails_helper'

RSpec.describe 'As a user', type: :feature do
  describe 'When I visit a Book review page' do
    before :each do
      @user = User.create!(name: "Billy")
      @author = Auther.create!(name: "Johnny Flapjacks")
      @book = @author.books.create!(title: "The Flour Revolution", pages: 155, year: 1999)
    end

    it 'has a form for review information' do
      visit review_path(@book)

      expect(page).to have_field("Title")
      expect(page).to have_field("Username")
      expect(page).to have_field("Rating")
      expect(page).to have_field("Review")
    end


  end
end
