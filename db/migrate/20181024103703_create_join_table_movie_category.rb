class CreateJoinTableMovieCategory < ActiveRecord::Migration[5.1]
  def change
    create_join_table :movies, :categories do |t|
      t.index [:movie_id, :category_id]
      t.index [:category_id, :movie_id]
    end
  end
end
