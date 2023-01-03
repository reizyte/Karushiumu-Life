class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :profile_image
  has_many :recipes, dependent: :destroy
  has_many :favorites, dependent: :destroy
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
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.png")
      profile_image.attach(io: File.open(file_path), filename: "default-image.png", content_type: "image/png")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end
end
