class Author < ApplicationRecord
  has_many :books_by_author
  has_many :books, through: :books_by_author

  validates_presence_of :name
end
