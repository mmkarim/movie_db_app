class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :movie, foreign_key: true, null: false
      t.integer :value, default: 1, null:false

      t.timestamps
    end

    add_index :ratings, [:movie_id, :user_id], unique: true
  end
end
