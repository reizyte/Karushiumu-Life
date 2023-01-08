class Public::RelationshipsController < ApplicationController
  before_action :authenticate_customer!

  def create
    followed = current_customer.relationships.build(follower_id: params[:customer_id])
    followed.save
    redirect_to request.referrer
  end

  def destroy
    followed = current_customer.relationships.find_by(follower_id: params[:customer_id])
    followed.destroy
    redirect_to request.referrer
  end
end
