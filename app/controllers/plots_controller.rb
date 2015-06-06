class PlotsController < ApplicationController
  before_action :set_plot, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, only:[ :create, :update, :destroy]
  after_action :set_trending_data, only: [:create]
  
  
  include TalesHelper
  # GET /fruits
  # GET /fruits.json
  def index
    @plots = Plot.all

  end

  # GET /fruits/1
  # GET /fruits/1.json
  def show
     

  end

  # GET /fruits/new
  def new
    @plot = Plot.new
    
    @authors =  Tale.where(id: params[:tale_id]).pluck(:user_id) 
    @followCount = Tale.find(params[:tale_id]).followers(User).count 
    @likeCount = Tale.find(params[:tale_id]).likers(User).count 
    @authorName = User.where(id: @authors[0]).pluck(:firstname)
    @titles =  Tale.where(id: params[:tale_id]).pluck(:title) 
    @tale_id = params[:tale_id]

  end

  # GET /fruits/1/edit
  def edit
  end

 


  # POST /fruits
  # POST /fruits.json
  def create
    @plot = Plot.new(plot_params)
    respond_to do |format|
    
    notification = 1  
    
      if @plot.save


        if @plot.user_id != current_user.id     # prevention of identity theft
            @plot.user_id = current_user.id
            @plot.save
        end
        @tale_author_id = Tale.where(id: @plot.tale_id).pluck(:user_id)
        unless (shared_emails(@plot.tale_id).include?current_user.email or (@plot.user_id ==@tale_author_id[0])) 
          @plot.destroy
        end

###        p = Plotphoto.new
###        p.plot_id = @plot.id
###        p.save

        
        format.html { redirect_to :controller => 'tales', :action => 'show', :id => @plot.tale_id }
        format.json { render json:@plot}
      else
        format.html { redirect_to :controller => 'tales', :action => 'show', :id => @plot.tale_id }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end

  
    
    end #redspond to
  end #def create

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
  def update


    
    respond_to do |format|



    if @plot.user_id == current_user.id

      if @plot.update(plot_params)
        #format.html { redirect_to plots_path, notice: 'Plot was successfully updated.' }
        taleId = @plot.tale_id.to_s
       # puts @plot.id
        
        format.html { redirect_to new_plot_path+ '?tale_id='+taleId, notice: 'Story was successfully exyended.' }
        format.json { render json:@plot}
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end

    end






    end
  end

  # DELETE /fruits/1
  # DELETE /fruits/1.json
  def destroy
    if current_user.id==@plot.user_id
    @plot.destroy
    respond_to do |format|
      format.html { redirect_to plots_url }
      format.json { head :no_content }
    end
  end
  end
  
  def set_trending_data
      numberOfLikes =  Tale.find(@plot.tale_id).likers(User).count 
      numberOfFollow = Tale.find(@plot.tale_id).followers(User).count 
      numberOfExtension = Plot.where(tale_id: @plot.tale_id).count


      numberOfFollowRecent = Follow.where(followable_type: Tale)
      numberOfFollowRecent = numberOfFollowRecent.where('created_at > ?', 3.days.ago).count
      
      numberOfLikesRecent = Like.where(likeable_type: Tale)
      numberOfLikesRecent = numberOfLikesRecent.where('created_at > ?', 3.days.ago).count

      numberOfExtensionRecent = Plot.where(tale_id: @plot.tale_id)
      numberOfExtensionRecent = numberOfExtensionRecent.where('created_at > ?', 3.days.ago).count


      Rails.logger.info numberOfFollowRecent
      Rails.logger.info numberOfLikesRecent
      Rails.logger.info numberOfExtensionRecent

      totalTrendingFactor = numberOfLikesRecent+(numberOfFollowRecent*2)+(numberOfExtensionRecent*3)
     Rails.logger.info totalTrendingFactor 
      t = Tale.where(id: @plot.tale_id)
      t[0].trending_factor = totalTrendingFactor
      t[0].save 
  end   


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plot
      @plot = Plot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plot_params
      params.require(:plot).permit(:tale_id, :description, :user_id)
    end
end
