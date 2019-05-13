class Author < ApplicationRecord
  has_many :books_by_author, dependent: :destroy
  has_many :books, through: :books_by_author

  validates_presence_of :name
  validates :name, uniqueness: true

  def book_count
    books.count
  end

  def top_three_books
    books.ratings_sort(:desc).limit(3)
  end
end
