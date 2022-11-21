class Public::RecipeCommentsController < ApplicationController
  before_action :authenticate_customer!, except:[:destroy]
  def create
    recipe = Recipe.find(params[:recipe_id])
    @comment = current_customer.recipe_comments.new(recipe_comment_params)
    @comment.recipe_id = recipe.id
    @comment.save
    redirect_to request.referer
    # else
    #   @cooking_materials = @recipe.cooking_materials
    #   @how_to_makes = @recipe.how_to_makes
    #   @recipe_comment = RecipeComment.new
    #   @recipe_tags = @recipe.tags
    #   render "public/recipes/show"
    # end
  end

  def destroy
    @comment = RecipeComment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private
  def recipe_comment_params
    params.require(:recipe_comment).permit(:comment)
  end

end
