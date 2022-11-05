class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  has_many :cooking_materials, dependent: :destroy
  accepts_nested_attributes_for :cooking_materials, :how_to_makes, allow_destroy: true
end
