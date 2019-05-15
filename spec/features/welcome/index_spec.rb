require 'rails_helper'

RSpec.describe 'When I visit the root of the website', type: :feature do
  it "I do not see the default nav bar" do
    visit root_path

    expect(page).to_not have_css("#nav")
  end

  describe 'I see two links to Authors and Books' do
    it 'When I click on Authors I go to the Authors index' do
      visit root_path

      click_link "Browse by Author"

      expect(current_path).to eq(authors_path)
    end

    it 'When I click on Books I go to the Books index' do
      visit root_path

      click_link "Browse by Book"

      expect(current_path).to eq(books_path)
    end
  end
end
