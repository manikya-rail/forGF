class Admin::ResortsController < ApplicationController
  #layout "display", only: [:display]
  layout "embed", only: :courses_list
  before_action :set_resort, only: [:show, :edit, :update, :destroy]
  after_action :set_version_header, only: :courses_list

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

    if @resort.save
      @flash_class = "alert alert-success"
      @message = "Resort added successfully."
    else
      @flash_class = "alert alert-danger"
      @message = "Something went wrong."
    end

    respond_to do |format|
      format.js
    end

  end

  # PATCH/PUT /resorts/1
  # PATCH/PUT /resorts/1.json
  def update
    respond_to do |format|
      if @resort.update(resort_params)
        format.html { redirect_to admin_resorts_path, notice: 'Resort was successfully updated.' }
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
      format.html { redirect_to admin_resorts_url, notice: 'Resort was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def courses_list
    @resort = Resort.find(params[:resort_id])
    @courses = @resort.courses
  end

  def courses
    @resort = Resort.find(params[:resort_id])
    @courses = @resort.courses
  end

  def add_course
    @resort = Resort.find(params[:resort_id])
    @resort.courses.build
    render 'admin/courses/new'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resort
      @resort = Resort.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resort_params
      params.require(:resort).permit(:name, :hide_logo, :hide_about_course, :lead_generation, :logo, :lead_url, :hide_carousel, :hide_score_card, :fore_btn_background, :fore_btn_text, :fore_line_color)
    end

    def set_version_header
      # response.set_header("X-Frame-Options", "ALLOWALL")
      response.headers.except! 'X-Frame-Options'
    end
end
