class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:sort].nil?
      @reviews = @user.reviews
    else
      @reviews = @user.reviews.sort_by_date(params[:sort])
    end
  end
end
