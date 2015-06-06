class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :finish_signup]
  
  def index
    if current_user.admin?
      @users = User.all
    end
      flash[:notice] = "Wrong place buddy !!"
  end
  def show
    # authorize! :read, @user
  end 
  def edit
    
    @roles = Role.all
  end

  def update
    # authorize! :update, @user
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  # def update
  #     @user = User.find(params[:id])
  #   if @user.update(user_params)
  #     flash[:notice] = "User role update"
  #     redirect_to users_path
  #   else
  #   	render edit
  #   end
  # end
  # GET/PATCH /users/:id/finish_signup
  def finish_signup
    # authorize! :update, @user 
    if request.patch? && params[:user] #&& params[:user][:email]
      if @user.update(user_params)
        #@user.skip_reconfirmation!
        sign_in(@user, :bypass => true)
        #redirect_to root_url, notice: 'Your profile was successfully updated.'
        redirect_to profiles_index_path(current_user.id)
      else
        @show_errors = true
      end
    end
  end

  # DELETE /users/:id.:format
  def destroy
    # authorize! :delete, @user
    if current_user.id==57 #identity theft prevention
    @user.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  end
  private
    def user_params
      accessible = [ :name, :email, :role_id ] # extend with your own params
      accessible << [ :password, :password_confirmation ] unless params[:user][:password].blank?
      params.require(:user).permit(accessible)
    	#params.require(:user).permit(:role_id)
    end
    def set_user
      @user = User.find(params[:id])	
    end
end


