class Public::CustomersController < ApplicationController

  def show
  end

  def edit
  end

  def update
  end

  def unsubscribe
  end

  def withdraw
  end

  #ブックマーク一覧
  def favorites

  end

  private

  def customer_params
    params.require(:customer).permit(:name, :introduction, :profile_image)
  end
end
