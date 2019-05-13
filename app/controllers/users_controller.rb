class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:sort].nil?
      @reviews = @user.reviews
    elsif params[:sort] == "newest" || params[:sort] == "oldest"
      @reviews = @user.reviews.sort_by_date(params[:sort])
    else
      @reviews = @user.reviews.sort_by_rating(params[:sort])
    end
  end
end
