class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    rating_params = {user_id: current_user.id, movie_id: params[:movie_id]}
    @rating = Rating.find_by(rating_params)
    @rating = Rating.new(rating_params) unless @rating

    @rating.value = params[:value]
    if valid_jwt?(params[:jwt]) && @rating.save
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end
end
