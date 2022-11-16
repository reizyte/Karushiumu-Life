class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except:[:index, :show, :search]
  def new
    @recipe = Recipe.new
    @cooking_materials = @recipe.cooking_materials.build  #親モデル.子モデル.buildで子モデルのインスタンス作成
    @how_to_makes = @recipe.how_to_makes.build
  end


  def index
    #キーワード検索
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result(distinct: true)
    #ジャンル検索
    @genres = Genre.all
    if params[:genre_id].present?
      #presentメソッドでparams[:genre_id]に値が含まれているか確認 => trueの場合下記を実行
      @genre = Genre.find(params[:genre_id])
      @recipes = @genre.recipes
    end
    @tag_list = Tag.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @cooking_materials = @recipe.cooking_materials
    @how_to_makes = @recipe.how_to_makes
    @recipe_comment = RecipeComment.new
    @recipe_tags = @recipe.tags
  end


  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @recipes = @tag.recipes.all
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.customer = current_customer
    # 受け取った値を「、」で区切って配列にする
    tag_list = params[:recipe][:tag_name].split("、")
    if @recipe.save
      @recipe.save_tag(tag_list)
    redirect_to recipe_path(@recipe), notice: "レシピの投稿に成功しました！"
    else
    render :new
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to customer_path(current_customer)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :explanation, :cooking_time, :serving, :image, :genre_id,
                                  how_to_makes_attributes:[:id, :cooking_procedure, :_destroy],
                                  cooking_materials_attributes:[:id, :material_name, :quantity, :_destroy]
                                  )

  end
end
