require 'rails_helper'

RSpec.describe 'When I visit the root of the website', type: :feature do
  describe 'I see two links to Authors and Books' do
    it 'When I click on Authors I go to the Authors index' do
      visit root_path

      click_link "Authors"

      expect(current_path).to eq("/authors")
    end

    it 'When I click on Books I go to the Books index' do
      visit root_path

      click_link "Books"

      expect(current_path).to eq("/books")
    end

  end
end
