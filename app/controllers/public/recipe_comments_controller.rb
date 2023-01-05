class Public::RecipeCommentsController < ApplicationController
  before_action :authenticate_customer!, except:[:destroy]
  before_action :set_recipe

  def create
    @recipe_comment = current_customer.recipe_comments.new(recipe_comment_params)
    @recipe_comment.recipe_id = @recipe.id
    if @recipe_comment.save
      redirect_to recipe_path(@recipe), notice: "コメントの投稿に成功しました！"
    else
      @cooking_materials = @recipe.cooking_materials
      @how_to_makes = @recipe.how_to_makes
      @tags = @recipe.tags
      render "public/recipes/show"
    end
  end

  def destroy
    @comment = RecipeComment.find(params[:id])
    return unless @comment.customer == current_customer || current_admin
    @comment.destroy
    redirect_to recipe_path(@recipe), notice: "コメントを削除しました。"
  end

  private

  def set_recipe
    @recipe = Recipe.find(params[:recipe_id])
  end

  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end
end
