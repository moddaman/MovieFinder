class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :signed_in_user
  before_action :set_user

  #@user = current_user

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @rating = Rating.where(movie_id: @movie.id, user_id: @current_user.id).first 
    unless @rating 
      @rating = Rating.create(movie_id: @movie.id, user_id: @current_user.id, score: 0) #TODO: fix so that users hwo dont rate dont give 0 automaticly
    end
  end

  # GET /movies/1
  # GET /movies/1.json
  def show_by_title
    @movie = Movie.find_by search_title: params[:search_title].downcase
    @rating = Rating.where(movie_id: @movie.id, user_id: @current_user.id).first 
    unless @rating 
      @rating = Rating.create(movie_id: @movie.id, user_id: @current_user.id, score: 0) #TODO: fix so that users hwo dont rate dont give 0 automaticly
    end
    render 'show'
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    if @current_user.admin?
      respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:imdb_id, :title, :tagline, :plot, :runtime, :rating, :votes, :poster_url, :release_date)
    end
end