class SearchController < ApplicationController

  require 'filmbuff'


  def search_movie
    movie = Movie.find_by search_title: params[:query]
    if movie
      @movie = movie
    elsif
      imdb = FilmBuff::IMDb.new
      movie = imdb.find_by_title(params[:query])
      @movie = Movie.new
      @movie.from_filmbuff(movie)
      @movie.save
    end
  end

  def search_micropost


  end


  def search_users
    @user = User.first
  end

end
