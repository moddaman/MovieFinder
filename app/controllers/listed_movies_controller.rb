class ListedMoviesController < ApplicationController
  before_action :signed_in_user

  def create
    puts "we are here"
    @movie = Movie.find(params[:movie_id])
    puts "here as well: #{@movie.inspect.to_s}"
    @user = current_user
    puts "and here: #{@user.inspect.to_s}"
    current_user.follow_movie(@movie)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end