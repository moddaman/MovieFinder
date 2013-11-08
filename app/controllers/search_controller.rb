class SearchController < ApplicationController

  require 'filmbuff'

  def search_movie
    movie = Movie.find_by search_title: params[:query]
    if movie
      @movie = movie
      @from_db = true
    elsif
      imdb = FilmBuff::IMDb.new
      movie = imdb.find_by_title(params[:query])
      @movie = Movie.new
      @movie.from_filmbuff(movie)
      @from_db = false
      @movie.save
    end
  end

end
