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
    add_authors(@book)

    if @book.save == true
      flash.notice = "'#{@book.title}' was added."
      redirect_to(book_path(@book))
    else
      flash.notice = "Looks like that title is already in the nook!"
      redirect_to new_book_path
    end
  end

  def destroy
    @book = Book.destroy(params[:id])

    flash.notice = "'#{@book.title}' was deleted."
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :year, :image)
  end

  def add_authors(book)
    book.authors << create_authors
  end

  def create_authors
    split_authors.map do |author|
      Author.find_or_create_by(name: author.titlecase)
    end
  end

  def split_authors
    params[:book][:authors].split(", ")
  end

  def find_order(value)
    value.start_with?("high") ? :desc : :asc
  end
end
