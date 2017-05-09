class Admin::HolesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_hole, only: [:show, :edit, :update, :destroy]

  # GET /holes
  # GET /holes.json
  def index
    @holes = Hole.all
  end

  # GET /holes/1
  # GET /holes/1.json
  def show
  end

  # GET /holes/new
  def new
    @hole = Hole.new
  end

  # GET /holes/1/edit
  def edit
  end

  # POST /holes
  # POST /holes.json
  def create
    @hole = Hole.new(hole_params)

    respond_to do |format|
      if @hole.save
        format.html { redirect_to @hole, notice: 'Hole was successfully created.' }
        format.json { render :show, status: :created, location: @hole }
      else
        format.html { render :new }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holes/1
  # PATCH/PUT /holes/1.json
  def update
    respond_to do |format|
      if @hole.update(hole_params)
        format.html { redirect_to @hole, notice: 'Hole was successfully updated.' }
        format.json { render :show, status: :ok, location: @hole }
      else
        format.html { render :edit }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holes/1
  # DELETE /holes/1.json
  def destroy
    @hole.destroy
    respond_to do |format|
      format.html { redirect_to holes_url, notice: 'Hole was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hole
      @hole = Hole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hole_params
      params.require(:hole).permit(:par, :yards, :mhcp, :whcp)
    end
end
