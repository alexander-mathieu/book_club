class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def review_count
    reviews.count
  end
end
