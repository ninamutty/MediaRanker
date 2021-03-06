class SongsController < ApplicationController
  def index
    @songs = Song.order('rank desc, id')
  end

  def find_song
    if Song.exists?(params[:id].to_i) == true
      return Song.find(params[:id].to_i)
    else
      render :status => 404
    end
  end

  def show
    @mysong = find_song
  end

  def upvote
    @mysong = find_song
    @mysong.upvote
    redirect_to :back
  end

  def downvote
    @mysong = find_song
    @mysong.downvote
    redirect_to :back
  end

  def new
    @mysong = Song.new
    @post_method = :post
    @post_path = songs_path
  end

  def create
    @params = params
    @mysong = Song.new
    @mysong.title = params[:song][:title]
    @mysong.artist = params[:song][:artist]
    @mysong.album = params[:song][:album]
    @mysong.genre = params[:song][:genre]
    @mysong.rank = 0

    if @mysong.save
      redirect_to songs_path
    else
      @error = "Did not save successfully. Try again. \nAll fields must be filled and address must be unique!"
      @post_method = :post
      @post_path = songs_path
      render :new
    end
  end

  def edit
    @mysong = find_song
    @post_method = :put
    @post_path = song_path(@mysong.id)
  end

  def update
    @params = params
    @mysong = find_song
    @mysong.title = params[:song][:title]
    @mysong.artist = params[:song][:artist]
    @mysong.album = params[:song][:album]
    @mysong.genre = params[:song][:genre]

    if @mysong.save
      redirect_to song_path(@mysong.id)
    else
      @error = "Did not save successfully. Try again. \nAll fields must be filled and address must be unique!"
      @post_method = :put
      @post_path = song_path(@mysong.id)
      render :edit
    end
  end

  def destroy
    @mysong = find_song
    if @mysong.class == Song
      @mysong.destroy
      redirect_to songs_path
    end
  end
end
