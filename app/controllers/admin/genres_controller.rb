class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_genre, only: [:edit, :destroy, :update]

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to request.referer, notice: "ジャンルの作成に成功しました！"
    else
      @genres = Genre.all
      render :index
    end
  end

  def destroy
    @genre.destroy
    redirect_to request.referer, notice: "ジャンルが削除されました。"
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルが更新されました！"
    else
      render :edit
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end


end
