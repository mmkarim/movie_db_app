class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :categories, :user_id, :average_ratings, :user_rating

  def user_rating
    if @instance_options[:user_id]
      Rating.find_by(movie_id: object.id, user_id: @instance_options[:user_id]).try(:value)
    end
  end
end
