class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  before_action :check_correct_user, only: [:edit, :update, :destroy]

  def index
    if request.format.json?
      @search  = MovieSearch.new(params)
      movies_count = @search.result.count
      @movies = @search.result.distinct.paginate(page).includes(:categories).order(:created_at)
      user_id = current_user.try(:id)
      result = ActiveModelSerializers::SerializableResource.new(@movies, each_serializer: MovieSerializer, adapter: :attributes, user_id: user_id)
      search_object = make_search_object
    end
    respond_to do |format|
      format.html
      format.json { render json: {movies: result, page: page, total_pages: Movie.total_pages(movies_count), search: search_object[:search], facet: search_object[:facet]}, status: :ok }
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

    def make_search_object
      result = {search: {}, facet: {}}

      result[:search][:average_rating] =  @search.filter(:average_rating).selected
      result[:facet][:average_rating] = @search.filter(:average_rating).facet.map do |facet|
        # next if !result[:search][:average_rating].empty? && !result[:search][:average_rating].include?(facet.entity)
        {entity: facet.entity.to_s, value: facet.entity, count: facet.count, selected: result[:search][:average_rating].include?(facet.entity)}
      end.compact

      result[:search][:categories] =  @search.filter(:categories).selected.map(&:id)
      result[:facet][:categories] = @search.filter(:categories).facet.map do |facet|
        # next if !result[:search][:categories].empty? && !result[:search][:categories].include?(facet.entity.id)
        {entity: facet.entity.name, value: facet.entity.id, count: facet.count, selected: result[:search][:categories].include?(facet.entity.id)}
      end.compact

      result[:search][:name] = @search.filter(:name).value || ""
      result
    end
end
