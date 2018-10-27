class AddUserToMovies < ActiveRecord::Migration[5.1]
  def change
    add_reference :movies, :user, foreign_key: true
    add_index :movies, [:user_id, :name], unique: true
  end
end
