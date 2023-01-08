class Public::CustomersController < ApplicationController
  before_action :ensure_correct_customer, only: [:update, :edit, :unsubscribe, :withdraw]
  before_action :set_customer, only: [:show, :edit, :update, :withdraw, :favorites, :followeds, :followers]

  def show
    @recipes = @customer.recipes.page(params[:page])
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "会員情報が更新されました！"
    else
      render :edit
    end
  end

  #退会確認
  def unsubscribe
  end

  #退会処理
  def withdraw
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path, notice: "退会しました。またのご利用お待ちしております。"
  end

  #お気に入り一覧
  def favorites
    @favorites = @customer.favorites.includes(:recipe).page(params[:page])
  end

  #フォロー一覧
  def followeds
    @customers = @customer.followeds
  end

  #フォロワー一覧
  def followers
    @customers = @customer.followers
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    if @customer != current_customer
      redirect_to customer_path(@customer), notice: "権限がありません。"
    elsif @customer.name == "guestcustomer"
      redirect_to customer_path(current_customer) , notice: "ゲストユーザは[プロフィール編集画面][退会画面]へ遷移できません。"
    end
  end
end
