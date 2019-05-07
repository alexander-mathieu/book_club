class Book < ApplicationRecord
  has_many :reviews
  has_many :books_by_author
  has_many :authors, through: :books_by_author

  validates_presence_of :title, :pages, :year
end
