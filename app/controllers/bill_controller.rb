class BillController < ApplicationController
  before_action :authenticate_user!
  def bill
    @user = current_user
    @bills = @user.bills
    @bill_total = []
    @bill_price = []
    i = 0
    @bills.each do |b|
      @bill_total[i] = 0
      @bill_price[i] = 0
      b.bill_items.each do |item|
        food = Food.find(item.food_id)
        if food && item
          @bill_price[i] = @bill_price[i] + item.total*food.price
          @bill_total[i] += item.total
        end
      end
      i+=1
    end
  end


  def add_bill
    @user = current_user
    bills = @user.bills
    bill = nil
    bills.each do |b|
      if b.status == 1
        bill = b
      end
    end
    if bill
      bill.bill_items.each do |item|
        if item.food_id == params[:id].to_i
          item.total = item.total + 1;
          item.save
          redirect_to root_path
          return
        end
      end
      bill.bill_items.create(food_id: params[:id],total:1)
    else
      current_user.bills.create(time: Time.new, status:1).bill_items.create(food_id: params[:id],total:1)
    end
    redirect_to root_path
  end

  def delete
    @user = current_user
    billItems = Bill.find(params[:id]).bill_items;
    billItems.each do |item|
      BillItem.delete(item.id)
    end
    Bill.delete(params[:id])
    redirect_to bill_bill_path
  end
end
