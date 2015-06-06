class SharingsController < ApplicationController
  before_action :set_sharing, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @sharings = Sharing.all
    respond_with(@sharings)
  end

  def show
    respond_with(@sharing)
  end

  def new
    @sharing = Sharing.new
    respond_with(@sharing)
  end

  def edit
  end

  def create
    @sharing = Sharing.new(sharing_params)


     shared_users_emails = Sharing.where(tale_id: @sharing.tale_id).pluck(:email) 
    

    unless shared_users_emails.include?@sharing.email      
      @sharing.save
      NotifyMailer.sharing_invitation(@sharing.email,@sharing.tale_id).deliver
      redirect_to :controller => 'tales', :action => 'show', :id => @sharing.tale_id 
    else 
      redirect_to :controller => 'tales', :action => 'show', :id => @sharing.tale_id 
    end
    

    
  end

  def update
    if current_user.id==57
    flash[:notice] = 'Sharing was successfully updated.' if @sharing.update(sharing_params)
    respond_with(@sharing)
  end
  end

  def destroy
    if current_user.id==57
    @sharing.destroy
    respond_with(@sharing)
  end
  end

  private
    def set_sharing
      @sharing = Sharing.find(params[:id])
    end

    def sharing_params
      params.require(:sharing).permit(:email, :tale_id)
    end
end
