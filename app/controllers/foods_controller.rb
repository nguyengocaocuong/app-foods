class FoodsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_food, only: %i[ show edit update destroy ]

  # GET /foods or /foods.json
  def index
    @user = current_user
    @foods = Food.all
  end

  # GET /foods/1 or /foods/1.json
  def show
    @user = current_user
    @categories = Category.all
  end

  # GET /foods/new
  def new
    @user = current_user
    @food = Food.new
    @categories = Category.all
  end

  # GET /foods/1/edit
  def edit
    @user = current_user
  end

  # POST /foods or /foods.json
  def create
    @user = current_user
    @food = Food.new(food_params)
   
    respond_to do |format|
      if @food.save
        format.html { redirect_to foods_url , notice: "Food was successfully created." }
        format.json { render :show, status: :created, location: @food }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /foods/1 or /foods/1.json
  def update
    respond_to do |format|
      if @food.update(food_params)
        format.html { redirect_to @food, notice: "Food was successfully updated." }
        format.json { render :show, status: :ok, location: @food }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @food.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /foods/1 or /foods/1.json
  def destroy
    items = BillItem.all
    items.each do |item|
      if item.food_id == @food.id
        respond_to do |format|
          format.html { redirect_to foods_url, notice: "Can't destroy this food!" }
          format.json { head :no_content }
          return
        end
      end
    end
    @food.destroy
    respond_to do |format|
      format.html { redirect_to foods_url, notice: "Food was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_food
      @food = Food.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def food_params
      params.require(:food).permit(:name, :price, :total, :decription, :vote, :image,:category_id)
    end
end
