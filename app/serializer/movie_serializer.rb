class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :text, :categories, :user_id, :average_rating, :user_rating

  def user_rating
    if @instance_options[:user_id]
      Rating.find_by(movie_id: object.id, user_id: @instance_options[:user_id]).try(:value)
    end
  end

  def average_rating
    object.average_rating.round(1).to_s
  end
end
