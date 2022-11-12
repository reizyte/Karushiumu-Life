class CookingMaterial < ApplicationRecord
  belongs_to :recipe

  validates :material_name, presence: true
  validates :quantity, presence: true
end
