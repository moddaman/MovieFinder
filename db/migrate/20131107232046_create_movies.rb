class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :imdb_id
      t.string :title
      t.string :tagline
      t.string :plot
      t.integer :runtime
      t.float :rating
      t.integer :votes
      t.string :poster_url
      t.date :release_date

      t.timestamps
    end
  end
end
