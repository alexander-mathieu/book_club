class ReviewsController < ApplicationController
  def new
    # require "pry"; binding.pry
    # @new_review = Review.new(book_id: params[:book_id])
    @new_review = Review.new
    # require "pry"; binding.pry
  end
end
