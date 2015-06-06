class FruitsController < ApplicationController
  before_action :set_fruit, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /fruits
  # GET /fruits.json
  def index
    @fruits = Fruit.all
  end

  # GET /fruits/1
  # GET /fruits/1.json
  def show
  end

  # GET /fruits/new
  def new
    @fruit = Fruit.new
  end

  # GET /fruits/1/edit
  def edit
  end

  # POST /fruits
  # POST /fruits.json
  def create
    @fruit = Fruit.new(fruit_params)

    respond_to do |format|
      if @fruit.save
        format.html { redirect_to fruits_path, notice: 'Fruit was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fruit }
      else
        format.html { render action: 'new' }
        format.json { render json: @fruit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
  def update
    respond_to do |format|
      if @fruit.update(fruit_params)
        format.html { redirect_to @fruit, notice: 'Fruit was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fruit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fruits/1
  # DELETE /fruits/1.json
  def destroy
    @fruit.destroy
    respond_to do |format|
      format.html { redirect_to fruits_url }
      format.json { head :no_content }
    end
  end
  

  def ruin
    fruits = Fruit.all  
    fruits.each do|f|
        f.destroy
    end
    respond_to do |format|
      format.html { redirect_to fruits_url }
      format.json { head :no_content }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fruit
      @fruit = Fruit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fruit_params
      params.require(:fruit).permit(:pulp)
    end
end
