class Book < ApplicationRecord
  has_many :reviews
  has_many :books_by_author
  has_many :authors, through: :books_by_author

  validates_presence_of :title, :pages, :year

  def author_names
    authors.pluck(:name)
  end

  def average_rating
    reviews.average(:rating)
  end

  def review_count
    reviews.count
  end

  def self.ratings_sort(order)
    if order == :desc
      select('books.*, AVG(reviews.rating) AS average_rating').joins(:reviews).group('books.id').order('average_rating DESC')
    else
      select('books.*, AVG(reviews.rating) AS average_rating').joins(:reviews).group('books.id').order('average_rating')
    end
  end

  def self.pages_sort(order)
    order(pages: order)
  end

  def self.reviews_sort(order)
    if order == :desc
      select('books.*, COUNT(reviews) AS review_count').joins(:reviews).group('books.id').order('review_count DESC')
    else
      select('books.*, COUNT(reviews) AS review_count').joins(:reviews).group('books.id').order('review_count')
    end
  end

end
