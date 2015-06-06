class TalesController < ApplicationController
  before_action :set_tale, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :update, :create, :destroy, :tales_list]
  before_action :find_genres, only: [:index, :new, :edit]
  after_action :set_trending_data, only: [:create, :follow, :unfollow, :like, :unlike]

  # GET /fruitss
  # GET /fruits.json
  def index
    #@current_tales = Tale.includes(:plots, :genres).not_featured.recent.filter(params[:filter])
    #@featured_tales = Tale.includes(:plots, :genres).filter(params[:filter]).featured
    
    #@current_tales = Tale.where(private_flag: 0).order('trending_factor').first(6)
    @current_tales = Tale.where(private_flag: 0, featured: true).first(6)
    
    if user_signed_in?
    

    @followings = Follow.where(follower_type: User, follower_id: current_user.id,followable_type: User).pluck(:followable_id)
    @recently_followed_tales = []
    for f in @followings
      @recently_followed_tales.push Tale.includes(:plots, :genres).not_featured.recent.where(user_id: f)
    end
    
    

    
    end

      #   if user_signed_in? 
      #      redirect_to activities_index_path
      #    end

  end

  # GET /fruits/1
  # GET /fruits/1.json
  def show

    @contributors =  Tale.contributors(@tale.id)
    @tale_id = @tale.id
    @authors =  Tale.where(id: @tale.id).pluck(:user_id) 
    @followCount = Tale.find(@tale.id).followers(User).count 
    @likeCount = Tale.find(@tale.id).likers(User).count 
    @authorName = User.where(id: @authors[0]).pluck(:firstname)
    @titles =  Tale.where(id: @tale.id).pluck(:title) 
    @talecover = Talephoto.where(tale_id: @tale.id)
    @subheadings = Tale.where(id: @tale.id).pluck(:subheading) 


    if @tale.private_flag==1
      if user_signed_in?
        if current_user.id!=@tale.user_id
          redirect_to '/'
        end
      else
        redirect_to '/'
      end
    end
  end


  def tales_list
    if current_user.admin?
      @lists = Tale.all
    else
     flash[:notice] = "Go to hell!!"
    end
  end
  # GET /fruits/new
  def new
    @tale = Tale.new
    plots = @tale.plots.build
  end

  # GET /fruits/1/edit
  def edit
  end

  # POST /fruits
  # POST /fruits.json
  def create
    @tale = Tale.new(tale_params)

    respond_to do |format|
      if @tale.save        
          #    @tale.create_activity :create, owner: current_user  
          # prevention of identity theft
          @tale.user_id = current_user.id
          @tale.save 
          taleId = @tale.id.to_s  


          #create notification
          Rails.logger.info("heelo Nishat Raihana");
          followers = Follow.where( followable_type: User, followable_id: current_user.id).pluck(:follower_id)

     followers.each do|follower|
          n = Journal.new
          n.notification_type = "StoryCreate"
          n.notification_id = @tale.id
          n.notification_to = follower
          n.save
     end     
      






          format.html { redirect_to :controller => 'tales', :action => 'show', :id => @tale.id }
          format.json { render action: 'show', status: :created, location: @tale }  

      else
        format.html { render action: 'new' }
        format.json { render json: @tale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
  def update
    respond_to do |format|

      if @tale.update(tale_params)#
        # prevention of identity theft
          @tale.user_id = current_user.id
          @tale.save 
        format.html { redirect_to '/', notice: 'Tale was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tale.errors, status: :unprocessable_entity }
      end





    end
  end

  # DELETE /fruits/1
  # DELETE /fruits/1.json
  def destroy
   
     
     #remove notification 
     #remove plots  


    if current_user.id==@tale.user_id
    notifications = Journal.where(notification_type: "StoryCreate", notification_id: @tale.id)
    notifications.each do|notification|
      notification.delete
    end  


    @tale.destroy






    respond_to do |format|
      #format.html { redirect_to tales_url }
      format.html { redirect_to profiles_index_path(current_user.id) }
      format.json { head :no_content }
    end
  end


  end


  def follow
     @tale = Tale.find(params[:followings_id])
     current_user.follow!(Tale.find(params[:followings_id]))
     set_trending_data
     
     if(params[:home].to_i==1.to_i)
        redirect_to '/'
     else
        redirect_to :controller => 'tales', :action => 'show', :id => @tale.id
     end   




  end

  def unfollow
    @tale = Tale.find(params[:followings_id])

     #redirect_to :controller => 'plots', :action => 'new', :tale_id => params[:followings_id]
     Rails.logger.info "hello"
     Rails.logger.info params[:home]
     Rails.logger.info "hello"
     if(params[:home].to_i==1.to_i)
        redirect_to '/'
     else
        redirect_to :controller => 'tales', :action => 'show', :id => @tale.id
     end   

        
  end

  def like
    @tale = Tale.find(params[:followings_id])
    current_user.like!(Tale.find(params[:followings_id]))
    redirect_to :controller => 'plots', :action => 'new', :tale_id => params[:followings_id]  


  end

  def unlike
    @tale = Tale.find(params[:followings_id])
    redirect_to :controller => 'plots', :action => 'new', :tale_id => params[:followings_id]
 
    end


  def featured_stories
  #  @current_tales = Tale.includes(:plots).not_featured.recent
    
    @featured_tales = Tale.featured

  end

  def trending_stories
    @current_tales = Tale.includes(:plots).not_featured.recent
    @trending_stories = Tale.order('trending_factor').first(5)
  end

 


  def set_trending_data
      numberOfLikes =  Tale.find(@tale.id).likers(User).count 
      numberOfFollow = Tale.find(@tale.id).followers(User).count 
      numberOfExtension = Plot.where(tale_id: @tale.id).count


      numberOfFollowRecent = Follow.where(followable_type: Tale)
      numberOfFollowRecent = numberOfFollowRecent.where('created_at > ?', 3.days.ago).count
      
      numberOfLikesRecent = Like.where(likeable_type: Tale)
      numberOfLikesRecent = numberOfLikesRecent.where('created_at > ?', 3.days.ago).count

      numberOfExtensionRecent = Plot.where(tale_id: @tale.id)
      numberOfExtensionRecent = numberOfExtensionRecent.where('created_at > ?', 3.days.ago).count


    
      totalTrendingFactor = numberOfLikesRecent+(numberOfFollowRecent*2)+(numberOfExtensionRecent*3)
    
      t = Tale.where(id: @tale.id)
      t[0].trending_factor = totalTrendingFactor
      t[0].save 
    
  end   
  
  

   private
    def find_genres
      @genres = Genre.all
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_tale
      @tale = Tale.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tale_params
      params.require(:tale).permit(:title, :subheading,:user_id, :genre_ids, :featured, :trending_factor, :cover, :private_flag, 

        :plots_attributes => [:description, :user_id])
    end
end
