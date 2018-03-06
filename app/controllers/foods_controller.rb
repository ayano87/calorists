class FoodsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
  end
  
  def new
    @food = Food.new
  end
  
  def show
    @food = Food.find(params[:id])
  end
  
  def update
  end
  
  def create
    @food = current_user.foods.build(food_params)
    if @food.save
      flash[:success] = '商品を投稿しました。'
      redirect_to root_url
    else
      @foods = current_user.foods.order('created_at DESC')
      flash.now[:danger] = '投稿に失敗しました。'
      render :new
    end
  end

  def destroy
    @food.destroy
    flash[:success] = '商品を削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private

  def food_params
    params.require(:food).permit(:name, :calorie, :image_url, :comment)
  end
  
  def correct_user
    @food = current_user.foods.find_by(id: params[:id])
    unless @food
      redirect_to root_url
    end
  end
end
