class FollowsController < ApplicationController
before_action :set_follow, only: [ :edit, :update, :destroy]

  # GET /fruits
  # GET /fruits.json
  def index
    @follows = Follow.all
  end


  # GET /fruits/new
  def new
    @follow = Follow.new
  end


  # POST /fruits
  # POST /fruits.json
  def create
    @follow = Follow.new(follow_params)

    respond_to do |format|
     if @follow.save
        #format.html { redirect_to profiles_index_path(current_user.id), alert: 'Thank You.' }
        format.json { render action: 'show', status: :created, location: @follow }     
    else 
      #  format.html { redirect_to profiles_index_path(current_user.id), alert: 'Thank You.' }
    end  

    end
  end

def edit 

end


def update
end
# DELETE /fruits/1
  # DELETE /fruits/1.json
  def destroy
    @follow.destroy


    respond_to do |format|
      #format.html { redirect_to tales_url }
     # format.html { redirect_to profiles_index_path(current_user.id) }
      format.json { head :no_content }
    end
  end




  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_follow
      @follow = Follow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def follow_params
      params.require(:follow).permit(:follower_type, :follower_id, :followable_type, :followable_id)
    end


end
