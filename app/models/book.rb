class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :books_by_author, dependent: :destroy
  has_many :authors, through: :books_by_author

  before_validation :titlecase_title

  validates :title, :pages, :year, presence: true
  validates :title, uniqueness: true

  def author_names
    authors.pluck(:name)
  end

  def average_rating
    rating = reviews.average(:rating)
    rating = 0 if rating == nil
    rating
  end

  def review_count
    reviews.count
  end

  def highest_three_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def lowest_three_reviews
    reviews.order(rating: :asc).limit(3)
  end

  def self.highest_three_rated
    ratings_sort(:desc).limit(3)
  end

  def self.lowest_three_rated
    ratings_sort(:asc).limit(3)
  end

  def self.ratings_sort(order)
    if order == :desc
      select('books.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
      .left_joins(:reviews)
      .group('books.id')
      .order('average_rating DESC')
    else
      select('books.*, COALESCE(AVG(reviews.rating), 0) AS average_rating')
      .left_joins(:reviews)
      .group('books.id')
      .order('average_rating')
    end
  end

  def self.pages_sort(order)
    order(pages: order)
  end

  def self.reviews_sort(order)
    if order == :desc
      select('books.*, COUNT(reviews) AS review_count')
      .left_joins(:reviews)
      .group('books.id')
      .order('review_count DESC')
    else
      select('books.*, COUNT(reviews) AS review_count')
      .left_joins(:reviews)
      .group('books.id')
      .order('review_count')
    end
  end

  def coauthors(current_author)
    author_names - [current_author.name]
  end

  private

  def titlecase_title
    write_attribute(:title, self.title.titlecase) unless self.title == nil
  end

end
