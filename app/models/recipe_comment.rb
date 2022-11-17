class RecipeComment < ApplicationRecord
  belongs_to :customer
  belongs_to :recipe

  validates :comment, length: {maximum: 150}
end
