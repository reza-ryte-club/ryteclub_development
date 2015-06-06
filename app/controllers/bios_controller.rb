class BiosController < ApplicationController
before_action :set_bio, only: [:show, :edit, :update, :destroy]

  # GET /fruits
  # GET /fruits.json
  def index
    @bios = Bio.all
  end


  # GET /fruits/new
  def new
    @bio = Bio.new
  end


  # POST /fruits
  # POST /fruits.json
  def create
    @bio = Bio.new(bio_params)

    respond_to do |format|


    #if @bio.user_id == current_user.id
    if @bio.save
        if @bio.user_id != current_user.id
           @bio.user_id = current_user.id
           @bio.save
        end
        format.html { redirect_to profiles_index_path(current_user.id), alert: 'Thank You.' }
        format.json { render action: 'show', status: :created, location: @bio }
     
    else 
        format.html { redirect_to profiles_index_path(current_user.id), alert: 'Thank You.' }
    end  




    end
  end

def edit 

end


def update
  if current_user.id== @bio.user_id
    respond_to do |format|
        if @bio.update(bio_params)
            main_bio = Bio.where(id: @bio.id)
            main_bio[0].user_id = current_user.id
            main_bio[0].save
        end  
            
        format.html { redirect_to profiles_index_path(current_user.id), notice: 'Story was successfully exyended.' }
        format.json { head :no_content }
    end
  end
  end




  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bio
      @bio = Bio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bio_params
      params.require(:bio).permit(  :user_id, :title)
    end


end
