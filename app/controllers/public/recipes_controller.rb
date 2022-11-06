class Public::RecipesController < ApplicationController

  def new
    @recipe = Recipe.new
    @cooking_materials = @recipe.cooking_materials.build  #親モデル.子モデル.buildで子モデルのインスタンス作成
    @how_to_makes = @recipe.how_to_makes.build
  end

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
    @cooking_materials = @recipe.cooking_materials
    @how_to_makes = @recipe.how_to_makes
  end

  def create
    @recipe = Recipe.new(recipe_params)
    #@recipe.genre = Genre.find(1)
    @recipe.customer = current_customer
    @recipe.save
    redirect_to recipe_path(@recipe)
  end

  def destroy
  end

  private

  def recipe_params
    params.require(:recipe).permit(:dish_name, :explanation, :cooking_time, :serving, :image, :genre_id,
                                  how_to_makes_attributes:[:cooking_procedure, :_destroy],
                                  cooking_materials_attributes:[:material_name, :quantity, :_destroy]
                                  )

  end
end
