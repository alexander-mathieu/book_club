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

  def self.rating_sort(param)
    order(:average_rating)
  end

end

# def self.order_by(param, type = nil)
#   if type == nil
#     type = "asc"
#   end
#   order("#{param} #{type}")
# end
