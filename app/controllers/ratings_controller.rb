class RatingsController < ApplicationController

  def update
    #@micropost = current_user.microposts.build(micropost_params)
    @rating = Rating.find(params[:id])
    @movie = @rating.movie
    if @rating.update_attributes(score: params[:score])
      respond_to do |format|
        format.js
      end
    end
  end

end