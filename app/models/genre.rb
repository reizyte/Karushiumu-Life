class Genre < ApplicationRecord
  has_many :resipes, dependent: :destroy
end
