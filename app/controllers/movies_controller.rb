class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  before_action :check_correct_user, only: [:edit, :update, :destroy]

  def index
    @movies = Movie.paginate(page).includes(:categories)
    user_id = current_user.try(:id)
    result = ActiveModelSerializers::SerializableResource.new(@movies, each_serializer: MovieSerializer, adapter: :attributes, user_id: user_id)

    respond_to do |format|
      format.html
      format.json { render json: {movies: result, page: page, total_pages: Movie.total_pages}, status: :ok }
    end
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def edit
  end

  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if valid_jwt?(params[:jwt]) && @movie.destroy
        head :no_content
     else
      render json: "", status: :unprocessable_entity
    end
  end

  private
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def movie_params
      params.require(:movie).permit(:name, :text, category_ids: [])
    end

    def page
      params[:page] || 1
    end

    def check_correct_user
      unless @movie.user_id == current_user.id
        respond_to do |format|
          format.html { redirect_to root_path, notice: 'Unauthorize access!' }
          format.json { render json: 'Unauthorize access!', status: :unprocessable_entity }
        end
      end
    end
end
