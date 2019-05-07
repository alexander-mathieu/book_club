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
end
