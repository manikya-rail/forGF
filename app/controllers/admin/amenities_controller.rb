class Admin::AmenitiesController < ApplicationController
  before_action :set_amenity, only: [:show, :edit, :update, :destroy]

  # GET /amenities
  # GET /amenities.json
  def index
    @amenities = Amenity.all
  end

  # GET /amenities/1
  # GET /amenities/1.json
  def show
  end

  # GET /amenities/new
  def new
    @amenity = Amenity.new
  end

  # GET /amenities/1/edit
  def edit
  end

  # POST /amenities
  # POST /amenities.json
  def create
    @amenity = Amenity.new(amenity_params)

    respond_to do |format|
      if @amenity.save
        format.html { redirect_to @amenity, notice: 'Amenity was successfully created.' }
        format.json { render :show, status: :created, location: @amenity }
      else
        format.html { render :new }
        format.json { render json: @amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amenities/1
  # PATCH/PUT /amenities/1.json
  def update
    respond_to do |format|
      if @amenity.update(amenity_params)
        format.html { redirect_to @amenity, notice: 'Amenity was successfully updated.' }
        format.json { render :show, status: :ok, location: @amenity }
      else
        format.html { render :edit }
        format.json { render json: @amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amenities/1
  # DELETE /amenities/1.json
  def destroy
    @amenity.destroy
    respond_to do |format|
      format.html { redirect_to amenities_url, notice: 'Amenity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity
      @amenity = Amenity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amenity_params
      params.require(:amenity).permit(:restaurants, :caddies, :carts)
    end
end
