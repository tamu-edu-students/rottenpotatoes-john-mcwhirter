class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]

  # GET /movies or /movies.json
  def index
    sort_column = params[:sort] || 'title'
    sort_direction = params[:direction] || 'asc'
    
    # Validate sort column to prevent injection
    allowed_columns = ['title', 'rating', 'release_date']
    sort_column = 'title' unless allowed_columns.include?(sort_column)
    
    # Validate sort direction
    sort_direction = 'asc' unless ['asc', 'desc'].include?(sort_direction)
    
    @movies = Movie.order("#{sort_column} #{sort_direction}")
    @sort_column = sort_column
    @sort_direction = sort_direction
  end

  # GET /movies/1 or /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies or /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        sort_params = { sort: params[:sort], direction: params[:direction] }.compact
        format.html { redirect_to movies_path(sort_params), notice: "Movie was successfully created." }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1 or /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: "Movie was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1 or /movies/1.json
  def destroy
    @movie.destroy!

    respond_to do |format|
      sort_params = { sort: params[:sort], direction: params[:direction] }.compact
      format.html { redirect_to movies_path(sort_params), notice: "Movie was successfully deleted.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def movie_params
      params.expect(movie: [ :title, :rating, :description, :release_date ])
    end
end
