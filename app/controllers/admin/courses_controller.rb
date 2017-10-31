class Admin::CoursesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    # @courses = Course.all
    @courses = Course.order("id DESC")
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    gon.videos = []
    gon.videos_urls = []
    gon.tags = []
    resolution = (is_mobile? ? 'mobile' : 'medium').to_sym
    @course.holes.sort_by{ |m| m.hole_num }.each do |hole|
      gon.videos << hole.video if hole.video.present?
      gon.videos_urls << hole.video.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if hole.video.present?
      gon.tags << hole.video.tags if hole.video.present?
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    @course.build_location
    @course.amenities.build
    @course.score_cards.build
    1..18.times do |index|
      @course.holes.build
    end
  end

  def holes
    @course = Course.find(params[:id])
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save

        if params[:images]
          params[:images].each { |image|
            @course.course_images.create(photo: image)
          }
        end
        format.html { redirect_to admin_holes_create_path(@course), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        if params[:images]
          params[:images].each { |image|
            @course.course_images.create(photo: image)
          }
        end
        format.html { redirect_to admin_courses_path, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :course_type, :bio, :website, :phone_num, :total_par, :slope, :rating, :length, :number_of_tees, :architect, :resort_id, :network_id, :logo, :cover, :score_card_image, :video,
          amenities_attributes: [:id, :restaurants, :caddies, :carts, :practice_range, :golf_boards],
          location_attributes: [:id, :town,:state, :lat, :lng],
          score_cards_attributes: [:id, :tee_name, :color, :_destroy],
          holes_attributes: [:id, :par, :yards, :mhcp, :whcp, :description, :hole_num]
        )
    end
end
