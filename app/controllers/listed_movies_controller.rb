class ListedMoviesController < ApplicationController
  before_action :signed_in_user

  def create
    @movie = Movie.find(params[:movie_id])
    @user = current_user
    if current_user.follow_movie(@movie)
      flash[:success] = @movie.title + " was added to your collection"
    end
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end