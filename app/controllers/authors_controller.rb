class AuthorsController < ApplicationController
  def index
    @authors = Author.all
  end

  def show
    @author = Author.find(params[:id])
    @books = @author.books
  end

  def destroy
    @author = Author.destroy(params[:id])

    flash.notice = "'#{@author.name}' was deleted."
    redirect_to books_path
  end
end
