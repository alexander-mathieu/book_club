class Review < ApplicationRecord
  belongs_to :user, :book

  validates_presence_of :text, :rating
end
