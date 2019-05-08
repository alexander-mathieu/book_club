class BooksController < ApplicationController
  def index
    @books = Book.all
    if params[:rating] != nil
      @books = @books.rating_sort(params[:rating])
    elsif params[:pages] != nil
      @books = @books.pages_sort(params[:pages])
    end
  end
end

# if params[:sort] != nil
#   @sorted_books = @books.order_by(params[:sort], params[:type])
# end
