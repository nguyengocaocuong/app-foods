class BillItemsController < ApplicationController
    before_action :authenticate_user!
    def show  
        @bill = Bill.find(params[:id])
        @user = current_user
       @billItems = Bill.find(params[:id]).bill_items
       @foods = []
       @billItems.each do |item|
        @foods.push(Food.find(item.food_id))
       end
    end
    def delete
        @bill = Bill.find(BillItem.find(params[:id]).bill_id)
        BillItem.delete(params[:id])
        redirect_to bill_bill_path
    end
    
    def order
        @bill = Bill.find(params[:id])
        b = Bill.find(params[:id])
        b.status = 2;
        b.save
        redirect_to bill_bill_path
    end
end
