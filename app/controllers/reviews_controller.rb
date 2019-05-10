class ReviewsController < ApplicationController
  def new
    @book = Book.find(params[:book_id])
    @new_review = Review.new
  end

  def create
    user = User.find_or_create_by(name: params[:user][:name].titlecase)
    book = Book.find(params[:book_id])
    new_review = user.reviews.new(review_params)
    book.reviews << new_review
    new_review.save

    redirect_to books_path(book)
  end

  def destroy
    # This is very confusing, but our Review ID is passed into params as :book_id because Reviews are nested resources of Book
    deleted_review = Review.find(params[:book_id])
    deleted_review.destroy

    redirect_to user_path(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :text)
  end
end
