class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :value, numericality: { greater_than: 0, less_than_or_equal_to: 5 }
  validates_presence_of :movie_id, :user_id, :value

  after_commit :update_movie_avg_rating!

  private
  def update_movie_avg_rating!
    self.movie.update_average_rating!
  rescue
  end
end
