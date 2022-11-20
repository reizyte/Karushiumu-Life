class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer

  def show
    @recipes = @customer.recipes.page(params[:page])
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customer_path(@customer), notice: "会員情報が更新されました！"
    else
      render :edit
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end
end
