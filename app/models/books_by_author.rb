class BooksByAuthor < ApplicationRecord
  belongs_to :book
  belongs_to :author
end
