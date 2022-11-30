class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_recipes, through: :favorites, source: :recipe
  has_many :recipe_comments, dependent: :destroy

  validates :name, presence: true
  validates :introduction, length: {maximum: 150}

  #ゲストログイン用
  def self.guest
    find_or_create_by!(name: "guestcustomer" ,email: "guest@example.com") do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end

  #プロフィールのデフォルト画像設定
  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.png"
  end
end
