class HowToMake < ApplicationRecord
  belongs_to :recipe

  validates :cooking_procedure, presence: true
end
