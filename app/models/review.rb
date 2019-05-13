class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates_presence_of :text, :rating, :title

  def date
    created_at.strftime("%d %B %Y")
  end

  def self.sort_by_date(sort)
    if sort == "newest"
      order(created_at: :desc)
    else
      order(created_at: :asc)
    end
  end
end
