class JournalsController < ApplicationController
  before_action :set_journal, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index]
  #before_action :authenticate_user!, only: [:new, :update, :create, :destroy, :tales_list]

  #after_action :set_trending_data, only: [:create, :follow, :unfollow, :like, :unlike]

  # GET /fruits
  # GET /fruits.json
  def index
  
      #   if user_signed_in? 
      #      redirect_to activities_index_path
      #    end

  end

  # GET /fruits/1
  # GET /fruits/1.json
  def show

  
  end
   # GET /fruits/new
  def new
    @journal = Journal.new
  end

  # GET /fruits/1/edit
  def edit
  end

  # POST /fruits
  # POST /fruits.json
  def create
    @journal = Journal.new(journal_params)

    respond_to do |format|
      if @journal.save
        
        
        
        #format.html { redirect_to new_plot_path+ '?tale_id='+taleId, notice: 'Story was successfully created.' }
        #format.json { render action: 'show', status: :created, location: @tale }
      else
       # format.html { render action: 'new' }
       # format.json { render json: @tale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fruits/1
  # PATCH/PUT /fruits/1.json
  def update
  #  respond_to do |format|
  #    if @tale.update(tale_params)
  #      format.html { redirect_to tales_path, notice: 'Tale was successfully updated.' }
  #      format.json { head :no_content }
  #    else
  #      format.html { render action: 'edit' }
  #      format.json { render json: @tale.errors, status: :unprocessable_entity }
  #    end
  #  end
  end

  def destroy
    @journal.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end




  
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_journal
      @journal = Journal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def journal_params
      params.require(:journal).permit(:notification_type, :notification_id, :notification_to)
    end
end
