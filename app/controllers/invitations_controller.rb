class InvitationsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

  # GET /fruitss
  # GET /fruits.json
  def index
  	 if user_signed_in?
   			@sign_up_counter = current_user.sign_in_count 
     end

     @emailMessage00 = "I want you to use this service."

  end

  # GET /fruits/1
  # GET /fruits/1.json
  def show

  end

  # GET /fruits/new
  def new
  	@invitation = Invitation.new

  end

  # GET /fruits/1/edit
  def edit
  end

  # POST /fruits
  # POST /fruits.json
  def create
    
    @invitation = Invitation.new(invitation_params)
	  if @invitation.save        
          	redirect_to '/' 
      end
  end

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
  def update
  end

  # DELETE /fruits/1
  # DELETE /fruits/1.json
  def destroy
   end


  
 

 
 


 


  
  

   private
    # Use callbacks to share common setup or constraints between actions.
    def set_invitation
      @invitation = Invitation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:from_email, :to_email, :tale_id, :message)
    end

	



end 