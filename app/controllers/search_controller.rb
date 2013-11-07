class SearchController < ApplicationController

  require 'filmbuff'

  def search_movie
    imdb = FilmBuff::IMDb.new
    @movie = imdb.find_by_title(params[:query])
  end

end
