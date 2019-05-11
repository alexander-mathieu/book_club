class BooksByAuthor < ApplicationRecord
  belongs_to :book, dependent: :destroy
  belongs_to :author
end
