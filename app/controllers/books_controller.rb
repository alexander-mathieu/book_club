class BooksController < ApplicationController
  def index
    @books = Book.all
    if params[:ratings] != nil
      sort_order  = find_order(params[:ratings])
      @books = @books.ratings_sort(sort_order)
    elsif params[:pages] != nil
      sort_order = find_order(params[:pages])
      @books = @books.pages_sort(sort_order)
    elsif params[:reviews] != nil
      sort_order = find_order(params[:reviews])
      @books = @books.reviews_sort(sort_order)
    end
  end

  private

  def find_order(value)
    value.start_with?("high") ? :desc : :asc
  end
end
