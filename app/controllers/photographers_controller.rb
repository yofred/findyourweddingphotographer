class PhotographersController < ApplicationController
  # gives access to these actions only to authorized users
  before_filter :authorize, :only => [:edit, :update, :destroy]

  # show all photographers
  def index
    @photographers = Photographer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @photographers }
    end
  end

  # show photographer
  def show
    @photographer = Photographer.find(params[:id])
    @photos = Photo.where(:photographer_id => @photographer.id)
    @galleries = Gallery.where(:photographer_id => @photographer.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @photographer }
    end
  end

  # create a new photographer
  def new
    @photographer = Photographer.new

    respond_to do |format|
      # format.html # new.html.erb
      format.json { render json: @photographer }
    end
  end
  
  # create a new Photographer object and establish a session
  def create
    @photographer = Photographer.new(params[:photographer])

    respond_to do |format|
      if @photographer.save
        session[:photographer_id] = @photographer.id
        
        format.html { redirect_to @photographer, notice: 'Photographer account was successfully created.' }
        format.json { render json: @photographer, status: :created, location: @photographer }
      else
        format.html { render action: "new" }
        format.json { render json: @photographer.errors, status: :unprocessable_entity }
      end
    end
  end

  # edit attributes of photogapher and send to update
  def edit
    @photographer = Photographer.find(params[:id])
  end

  # update attributes of a Photographer object, redirect to photographer#show
  def update
    @photographer = Photographer.find(params[:id])

    respond_to do |format|
      if @photographer.update_attributes(params[:photographer])
        format.html { redirect_to @photographer, notice: 'Photographer account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photographer.errors, status: :unprocessable_entity }
      end
    end
  end

  # deletes a Photographer object
  def destroy
    @photographer = Photographer.find(params[:id])
    @photographer.destroy

    respond_to do |format|
      format.html { redirect_to photographers_url }
      format.json { head :no_content }
    end
  end
end
