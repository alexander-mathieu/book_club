class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :text, :rating

  def date
    created_at.strftime("%d %B %Y")
  end
end
