class Customers::SessionsController < Devise::SessionsController
  #ゲストログイン用
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to customer_path(current_customer), notice: "ゲストユーザでログインしました。"
  end
end