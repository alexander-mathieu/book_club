class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if params[:sort].nil?
      @reviews = @user.reviews
    else
      @reviews = @user.reviews.sort_by(params[:sort])
    end
  end
end
