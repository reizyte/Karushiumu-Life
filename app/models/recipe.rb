class Recipe < ApplicationRecord
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  has_many :cooking_materials, dependent: :destroy
end
