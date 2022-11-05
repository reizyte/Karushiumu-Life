class RecipeComment < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe
end
