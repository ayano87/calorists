class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    food = Food.find(params[:food_id])
    current_user.favorite(food)
    flash[:success] = "お気に入りに登録しました。"
    redirect_back(fallback_location: root_url)
  end

  def destroy
    food = Food.find(params[:food_id])
    current_user.unfavorite(food)
    flash[:success] = "お気に入りを解除しました。"
    redirect_back(fallback_location: root_url)
  end
end
