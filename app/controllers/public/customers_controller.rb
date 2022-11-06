class Public::CustomersController < ApplicationController

  def show
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_path
    else
      render :edit
    end
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
