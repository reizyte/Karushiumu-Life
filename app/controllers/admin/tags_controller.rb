class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: [:edit, :destroy, :update]

  def index
    @tag = Tag.new
    @tags = Tag.all
  end

  def edit
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to request.referer, notice: "タグの作成に成功しました！"
    else
      @tags = Tag.all
      render :index
    end
  end

  def destroy
    @tag.destroy
    redirect_to request.referer, notice: "タグが削除されました。"
  end

  def update
    if @tag.update(tag_params)
      redirect_to admin_tags_path, notice: "タグが更新されました！"
    else
      render :edit
    end
  end

  private
  
  def set_tag
    @tag = Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:tag_name)
  end
end
