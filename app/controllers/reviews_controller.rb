class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @new_review = Review.new
  end
end
