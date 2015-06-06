class TalephotosController < ApplicationController
  before_action :set_talephoto, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @talephotos = Talephoto.all
    respond_with(@talephotos)
  end

  def show
    respond_with(@talephoto)
  end

  def new
    @talephoto = Talephoto.new
    respond_with(@talephoto)
  end

  def edit
  end

  def create
    @talephoto = Talephoto.new(talephoto_params)

    if @talephoto.save
        talephotos = Talephoto.all
        talephotos.each do|talephoto|
          if(@talephoto.id!=talephoto.id)
            if(@talephoto.tale_id==talephoto.tale_id)
                  talephoto.delete 
            end
          end      
        end
     end   


    flash[:notice] = 'Talephoto was successfully created.' if @talephoto.save
    respond_with(@talephoto)
  end

  def update
    flash[:notice] = 'Talephoto was successfully updated.' if @talephoto.update(talephoto_params)
    respond_with(@talephoto)
  end

  def destroy
    @talephoto.destroy
    respond_with(@talephoto)
  end

  private
    def set_talephoto
      @talephoto = Talephoto.find(params[:id])
    end

    def talephoto_params
      params.require(:talephoto).permit(:cover, :tale_id)
    end
end
