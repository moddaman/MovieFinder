class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  require 'filmbuff'


  def index
    @users = User.search(params[:search])
    @microposts = Micropost.search(params[:search])
    movie = Movie.find_by search_title: params[:search]
    if movie
      @movie = movie
      @from_db = true
    elsif
     imdb = FilmBuff::IMDb.new
      movie = imdb.find_by_title(params[:search])
      @movie = Movie.new
      @movie.from_filmbuff(movie)
      @from_db = false
      @movie.save
    end
    #@users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    all_rated_movies = @user.ratings.where(:score => 1).all
    all_rated_movies = all_rated_movies.sort { |a,b| a.score <=> b.score }
    all_rated_movies.reverse!
    @toprated = all_rated_movies.take(20)
  end

  def new
    @user = User.new
  end

  def edit
   # @user = User.find(params[:id])
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Movie thingy!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Before filters

 # def signed_in_user
  #  unless signed_in?
   #   store_location
   #   redirect_to signin_url, notice: "Please sign in."
   # end
 # end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
