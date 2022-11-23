class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except:[:index, :show, :search]
  before_action :set_recipe, only: [:show, :destroy]

  def new
    @recipe = Recipe.new
    @cooking_materials = @recipe.cooking_materials.build  #親モデル.子モデル.buildで子モデルのインスタンス作成
    @how_to_makes = @recipe.how_to_makes.build  #親モデル.子モデル.buildで子モデルのインスタンス作成
  end

  def index
    #キーワード検索
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true).page(params[:page])
    #ジャンル検索
    @genres = Genre.all
    if params[:genre_id].present?  #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes.page(params[:page])
    end
    #タグ検索
    @tags = Tag.all
    if params[:tag_id].present?  #presentメソッドでparams[:tag_id]に値が含まれているか確認 => trueの場合下記を実行
      @tag = Tag.find(params[:tag_id])
      @recipes = @tag.recipes.page(params[:page])
    end
  end

  def show
    @cooking_materials = @recipe.cooking_materials
    @how_to_makes = @recipe.how_to_makes
    @recipe_comment = RecipeComment.new
    @tags = @recipe.tags
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer_id = current_customer.id
    if @recipe.save
      redirect_to recipe_path(@recipe), notice: "レシピの投稿に成功しました！"
    else
      render :new
    end
  end

  def destroy
    @recipe.destroy
    redirect_to customer_path(current_customer), notice: "レシピを削除しました。"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:dish_name, :explanation, :cooking_time, :serving, :image, :genre_id,
      tag_ids: [],
      how_to_makes_attributes: [:id, :cooking_procedure, :_destroy],
      cooking_materials_attributes: [:id, :material_name, :quantity, :_destroy]
    )
  end
end
