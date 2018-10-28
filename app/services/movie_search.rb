class MovieSearch
  def initialize(params, page, user_id)
    @average_ratings = params[:search].try(:[],:average_rating)|| []
    @category_ids = params[:search].try(:[], :categories) || []
    @name = params[:search].try(:[], :name) || ""
    @result = {search: {}, facet: {}}
    @movies = movie_query
    @user_id = user_id
    @page = page
  end

  def filter
    binding.pry
    make_category_facet_object
    make_avg_rating_facet_object
    @result[:movies] = create_movie_list
    @result[:count] = @movies.count
    @result[:search][:name] = @name
    @result
  end

  private
  def avg_rating_condition
    @average_ratings.empty? ? nil : {average_rating: @average_ratings}
  end

  def category_condition
    @category_ids.empty? ? nil : {categories: {id: @category_ids}}
  end

  def name_condition
    @name.empty? ? nil : "movies.name LIKE '%#{@name}%'"
  end

  def movie_query
    Movie.left_joins(:categories)
    .where(avg_rating_condition)
    .where(category_condition)
    .where(name_condition)
    .distinct.includes(:categories, :ratings)
  end

  def make_category_facet_object
    @result[:search][:categories] = @category_ids
    @result[:facet][:categories] = @movies.group(["categories.id", "categories.name"]).count.map do |key, value|
      id = key[0]
      name = key[1]
      next if id.nil?

      facet_object name, id, value, @result[:search][:categories].include?(id.to_s)
    end.compact
  end

  def make_avg_rating_facet_object
    @result[:search][:average_rating] = @average_ratings
    @result[:facet][:average_rating] = @movies.group(:average_rating).count.map do |key, value|
      key = key.to_s
      facet_object key, key, value, @result[:search][:average_rating].include?(key)
    end
  end

  def create_movie_list
    ActiveModelSerializers::SerializableResource.new(
      @movies.paginate(@page),
      each_serializer: MovieSerializer,
      adapter: :attributes,
      user_id: @user_id
    )
  end

  def facet_object entity, value, count, selected
    {entity: entity, value: value, count: count, selected: selected}
  end
end
