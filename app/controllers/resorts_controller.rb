class Admin::ResortsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_resort, only: [:show, :edit, :update, :destroy]

  # GET /resorts
  # GET /resorts.json
  def index
    @resorts = Resort.all
  end

  # GET /resorts/1
  # GET /resorts/1.json
  def show
  end

  # GET /resorts/new
  def new
    @resort = Resort.new
  end

  # GET /resorts/1/edit
  def edit
  end

  # POST /resorts
  # POST /resorts.json
  def create
    @resort = Resort.new(resort_params)

    respond_to do |format|
      if @resort.save
        format.html { redirect_to @resort, notice: 'Resort was successfully created.' }
        format.json { render :show, status: :created, location: @resort }
      else
        format.html { render :new }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resorts/1
  # PATCH/PUT /resorts/1.json
  def update
    respond_to do |format|
      if @resort.update(resort_params)
        format.html { redirect_to @resort, notice: 'Resort was successfully updated.' }
        format.json { render :show, status: :ok, location: @resort }
      else
        format.html { render :edit }
        format.json { render json: @resort.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resorts/1
  # DELETE /resorts/1.json
  def destroy
    @resort.destroy
    respond_to do |format|
      format.html { redirect_to resorts_url, notice: 'Resort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resort
      @resort = Resort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resort_params
      params.require(:resort).permit(:name)
    end
end
