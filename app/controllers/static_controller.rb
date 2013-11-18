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
      @toprated = @user.top_rated

    end
  end

end