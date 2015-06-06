class FollowersController < ApplicationController
  #before_action :set_follower, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  # GET /fruits
  # GET /fruits.json
  def index
    @followers = Follower.all
  end


  def follow
    f = Follower.new
    f.user_id = params[:current_user_id]
    f.followings_id = params[:followings_id]
    f.save
    redirect_to '/'
  end

  def unfollow
    f = Follower.where(user_id: params[:current_user_id],followings_id: params[:followings_id])
    Follower.destroy(f)
    redirect_to '/'
  end


  # GET /fruits/1
  # GET /fruits/1.json
  def show
  end

  # GET /fruits/new
  def new
    @follower = Follower.new
  end

  # GET /fruits/1/edit
#  def edit
 # end


  # POST /fruits
  # POST /fruits.json
#  def create
 #   @follower = Follower.new(follower_params)

#    respond_to do |format|
 #     if @follower.save
  #      format.html { redirect_to tales_path, notice: 'Story was successfully created.' }
   #     format.json { render action: 'show', status: :created, location: @plot }
    #  else
     #   format.html { render action: 'new' }
      #  format.json { render json: @plot.errors, status: :unprocessable_entity }
     # end
    #end
  #end

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
 # def update
#    respond_to do |format|
 #     if @plot.update(plot_params)
  #      format.html { redirect_to plots_path, notice: 'Plot was successfully updated.' }
   #     format.json { head :no_content }
    #  else
     #   format.html { render action: 'edit' }
      #  format.json { render json: @plot.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # DELETE /fruits/1
  # DELETE /fruits/1.json
  #def destroy
  #  @plot.destroy
  #  respond_to do |format|
  #    format.html { redirect_to plots_url }
  #    format.json { head :no_content }
  #  end
  #end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follower
      @follower = Follower.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follower_params
      params.require(:follower).permit(:user_id,:followings_id)
    end
end
