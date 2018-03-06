class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @foods = Food.all.order(calorie: :desc)
    end
  end
end
