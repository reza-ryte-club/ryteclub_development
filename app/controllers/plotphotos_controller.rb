class PlotphotosController < ApplicationController
  before_action :set_plotphoto, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @plotphotos = Plotphoto.all
    respond_with(@plotphotos)
  end

  def show
    respond_with(@plotphoto)
      
  end

  def new
    @plotphoto = Plotphoto.new
    respond_with(@plotphoto)
  end

  def edit
  end

  def create
    @plotphoto = Plotphoto.new(plotphoto_params)
    flash[:notice] = 'Plotphoto was successfully created.' if @plotphoto.save
    respond_with(@plotphoto)
  end

  def update
    flash[:notice] = 'Plotphoto was successfully updated.' if @plotphoto.update(plotphoto_params)
    respond_with(@plotphoto)
  end

  def destroy
    @plotphoto.destroy
    respond_with(@plotphoto)
  end

  private
    def set_plotphoto
      @plotphoto = Plotphoto.find(params[:id])
    end

    def plotphoto_params
      params.require(:plotphoto).permit(:image, :plot_id)
    end
end
