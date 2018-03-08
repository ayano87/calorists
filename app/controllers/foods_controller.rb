class FoodsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def new
    @food = Food.new
  end
  
  def show
    @food = Food.find(params[:id])
  end
  
  def edit
    @food = Food.find(params[:id])
  end
  
  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      flash[:success] = '商品を編集しました。'
      redirect_to @food
    else
      flash.now[:danger] = '編集に失敗しました。'
      render :edit
    end
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
    @food = Food.find(params[:id])
    @food.destroy
    flash[:success] = '商品を削除しました。'
    redirect_to root_url
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
