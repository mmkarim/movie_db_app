class RatingsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    @rating = Rating.find_or_create_by(user_id: current_user.id, movie_id: params[:movie_id])
    @rating.value = params[:value]

    if valid_jwt?(params[:jwt]) && @rating.save
      render json: @rating, status: :created
    else
      binding.pry
      render json: @rating.errors, status: :unprocessable_entity
    end
  end
end
