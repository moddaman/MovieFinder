class StaticController < ApplicationController


  def home
    if signed_in?
    end
  end

  def feed
    if signed_in?
      @user = current_user
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
      all_rated_movies = @user.ratings.all
      all_rated_movies = all_rated_movies.sort { |a,b| a.score <=> b.score }
      all_rated_movies.reverse!
      @toprated = all_rated_movies.take(10)

    end
  end

 end