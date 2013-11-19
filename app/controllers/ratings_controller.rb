class RatingsController < ApplicationController


  def update
    @rating = Rating.find(params[:id])
    @movie = @rating.movie
    if @rating.update_attributes(score: params[:score])
      @micropost = current_user.microposts.new(content: post)
      @micropost.save
      respond_to do |format|
        format.js
      end
    end
  end

  def post
    if @rating.score < 2
      return 'Gave the movie ' + @rating.movie.title.to_s + ' only ' +  @rating.score.to_s + ' star'
    end
    'Gave the movie ' + @rating.movie.title.to_s + ' ' +  @rating.score.to_s + ' stars'
  end

end