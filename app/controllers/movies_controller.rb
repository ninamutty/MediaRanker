class MoviesController < ApplicationController
  def index
    @movies = Movie.all.order(rank: :desc)
  end

  def find_movie
    return Movie.find(params[:id].to_i)
  end

  def show
    @mymovie = find_movie
  end

  def upvote
    @mymovie = find_movie
    @mymovie.rank += 1
    @mymovie.save
    render :show
  end

  def downvote
    @mymovie = find_movie
    @mymovie.rank -= 1
    @mymovie.save
    render :show
  end

  def new
    @mymovie = Movie.new
    @post_method = :post
    @post_path = movies_path
  end

  def create
    @params = params
    @mymovie = Movie.new
    @mymovie.title = params[:movie][:title]
    @mymovie.director = params[:movie][:director]
    @mymovie.genre = params[:movie][:genre]
    @mymovie.description = params[:movie][:description]
    @mymovie.rank = 0

    if @mymovie.save
      redirect_to movies_path
    else
      @error = "Did not save successfully. Try again. \nAll fields must be filled and address must be unique!"
      @post_method = :post
      @post_path = movies_path
      render :new_movie
    end
  end

  def edit
    @mymovie = find_movie
    @post_method = :put
    @post_path = movie_path(@mymovie.id)
  end

  def update
    @params = params
    @mymovie = find_movie
    @mymovie.title = params[:movie][:title]
    @mymovie.director = params[:movie][:director]
    @mymovie.genre = params[:movie][:genre]
    @mymovie.description = params[:movie][:description]

    if @mymovie.save
      redirect_to movie_path(@mymovie.id)
    else
      @error = "Did not save successfully. Try again. \nAll fields must be filled and address must be unique!"
      @post_method = :put
      @post_path = movie_path(@mymovie.id)
      render :edit_movie
    end
  end

  def destroy
    @mymovie = find_movie
    if @mymovie != nil
      @mymovie.destroy
      redirect_to movies_path
    end
  end
end