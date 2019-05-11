class User < ApplicationRecord
  has_many :reviews

  validates_presence_of :name

  def review_count
    reviews.count
  end

  def self.top_three_users
    joins(:reviews)
    .select('users.*, COUNT(reviews) AS review_count')
    .group('users.id')
    .order('review_count DESC')
    .limit(3)
  end
end
