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

  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.save

    redirect_to(book_path(@book))
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year, :image)
  end

  def find_order(value)
    value.start_with?("high") ? :desc : :asc
  end
end
