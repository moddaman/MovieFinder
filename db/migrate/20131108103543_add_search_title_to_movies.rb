class AddSearchTitleToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :search_title, :string
  end
end
