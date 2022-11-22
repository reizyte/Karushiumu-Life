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
  def get_image
    (image.attached?) ? image : "recipe_no_image.png"
  end

  #引数の会員idがFavoritesテーブル内に存在（exists?）するかどうか調べる
  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_recipe_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_recipe_tag
    end
  end
end
