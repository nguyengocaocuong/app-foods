class StaticPagesController < ApplicationController
  def home
  # bill = Food.all
  # bill.each do |item|
  #   Food.delete(item.id)
  # end
  # bill = Category.all
  # bill.each do |item|
  #   Category.delete(item.id)
  # end

    @user = current_user
    @active = -1
    @categories = Category.all
    if params[:id] 
      @foods = Category.find(params[:id]).foods
      @active = params[:id]
    else  
    @foods = Food.all
    end
  end
  # def  filter

  # end
end
