class Admin::CoursesController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # GET /courses
  # GET /courses.json

  def add_playlist_item
    @video_index = params["video_index"].to_i    
  end

  def add_scorecard
    @scorecard_index = params["scorecard_index"].to_i    
  end

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
    @resort = Resort.new
    @resort.build_location
    @resort.courses.build
    # @course.amenities.build
    # @course.score_cards.build
    # 1..18.times do |index|
    #   @course.holes.build
    # end
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
    if params[:resort_id].blank?
      @resort = Resort.new(resort_params)
    else
      @resort = Resort.find(params[:resort_id])
      @resort.assign_attributes(resort_params)
    end
    if @resort.save
      @course = @resort.courses.last
      if params[:images]
        params[:images].each { |image| @course.course_images.create(photo: image)}
      end
      if params[:score_cards]
        params[:score_cards].each do |scorecard_index, scorecard_params|
          score_card = @course.score_cards.create(tee_name: scorecard_params[:tee_name], 
            color: scorecard_params[:color], rating: scorecard_params[:total_rating],
            slope: scorecard_params[:total_slope])
          scorecard_params[:holes].each do |hole_num, hole_params|
            hole = @course.holes.find_or_create_by(hole_num: hole_num)
            if score_card.present? && hole.present?
              yardage = score_card.yardages.find_or_create_by(hole_id: hole.id, yards: hole_params[:yardges])
              par = score_card.pars.find_or_create_by(hole_id: hole.id, par: hole_params[:par])
              hcp = score_card.hcps.find_or_create_by(hole_id: hole.id, hcp: hole_params[:hcp])
            end
          end
        end
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
        if params[:score_images]
          params[:score_images].each { |image|
            @course.scorecard_images.create(photo: image)
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
  
  def remove_course_image
    if params[:for].present?
       course = Course.find(params[:course_id]) 
       if params[:for] == "logo"
         course.logo = nil
         course.save
       elsif params[:for] == "transparent"
         course.transparent_logo = nil
         course.save
       elsif params[:for] == "cover"
         course.cover = nil
         course.save
       elsif params[:for] == "score_card"
         course.scorecard_images.select { |aimage| aimage.photo.url == params[:image_source] }.first.destroy()
       end
    else
     CourseImage.find(params[:course_id]).delete
    end 
    render :json => {status: 'success'}, :layout => false
  end

  def update_holes
    course = Course.find(params[:course_id])
    params[:holes].each do |hole_id, hole_params|
      hole = Hole.find(hole_id)
      hole.build_video(video: hole_params[:video]) if hole_params[:video].present?
      hole.image = hole_params[:cover] if hole_params[:cover].present?
      hole.map = hole_params[:map] if hole_params[:map].present?
      hole.description = hole_params[:description]
      hole.save
      if hole_params[:images].present?
        hole_params[:images].each do |image|
          hole.hole_images.create(image: image)
        end
      end
    end
    if params[:commit] == "Save"
      redirect_to admin_courses_path
    else
      @resort = course.resort
      @resort.courses.build
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id]) rescue nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :course_type, :bio, :website, :phone_num, :color_selector, :total_par, :slope, :rating, :length, :number_of_tees, :architect, :resort_id, :network_id, :logo, :cover, :video, :transparent_logo, :logo_hyperlink,
          amenities_attributes: [:id, :restaurants, :caddies, :carts, :practice_range, :golf_boards],
          location_attributes: [:id, :town,:state, :lat, :lng],
          score_cards_attributes: [:id, :tee_name, :color, :rating, :slope, :_destroy],
          holes_attributes: [:id, :par, :yards, :mhcp, :whcp, :description, :hole_num]
        )
    end

    def resort_params
      params.require(:resort).permit(:name, :resort_type, :website, :phone_num, :network_id, location_attributes: [:town,:state, :lat, :lng], courses_attributes: [:name, :bio, :color_selector, videos_attributes: [:title, :description, :video]])
    end
end
