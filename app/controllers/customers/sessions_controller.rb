class Customers::SessionsController < Devise::SessionsController
  #ゲストログイン用
  def guest_sign_in
    customer = Customer.guest
    sign_in customer
    redirect_to root_path, notice: "ゲストユーザでログインしました。"
  end
end