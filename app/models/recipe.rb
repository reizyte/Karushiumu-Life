class Recipe < ApplicationRecord
  has_one_attached :image
  belongs_to :customer
  belongs_to :genre
  has_many :favorites, dependent: :destroy
  has_many :recipe_comments, dependent: :destroy
  has_many :how_to_makes, dependent: :destroy
  has_many :cooking_materials, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :tags, through: :recipe_tags
  accepts_nested_attributes_for :cooking_materials, :how_to_makes, allow_destroy: true

  validates :dish_name, presence: true, length: {maximum: 25}
  validates :explanation, presence: true, length: {maximum: 70}
  validates :cooking_time, presence: true
  validates :serving, presence: true

  #レシピ画像が無い場合のデフォルト画像
  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join("app/assets/images/recipe_no_image.png")
      image.attach(io: File.open(file_path), filename: "default-image.png", content_type: "image/png")
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

  #引数の会員idがFavoritesテーブル内に存在（exists?）するかどうか調べる
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end
end
