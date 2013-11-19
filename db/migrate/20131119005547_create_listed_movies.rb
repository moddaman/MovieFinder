class CreateListedMovies < ActiveRecord::Migration
  def change
    create_table :listed_movies do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
  end
end
