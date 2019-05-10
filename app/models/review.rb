class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :text, :rating

  def date
    created_at.strftime("%d %B %Y")
  end

  def self.sort_by_date(sort)
    if sort == "newest"
      order(created_at: :asc)
    else
      order(created_at: :desc)
    end
  end
end
