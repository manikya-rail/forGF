class Admin::CoursesController < ApplicationController
  #require 'fileutils'
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
    @course.videos.build
  end

  # POST /courses
  # POST /courses.json
  def create
    if params[:resort_id].blank?
      @resort = Resort.new(resort_params)
    else
      @resort = Resort.find(params[:resort_id])
      courses_params = params[:resort][:courses_attributes]["0"]
      @course = @resort.courses.create(name: courses_params[:name], bio: courses_params[:bio], color_selector: courses_params[:color_selector], cover: courses_params[:cover])
    end
    if @resort.save
      @course = @resort.courses.last if @course.nil?
      if params[:images].present?
        Thread.new do
          params[:images].each_with_index do |image, index|
            @course.course_images.create(photo: image)
          end
          if params[:scorecard_images].present?
            params[:scorecard_images].each { |scorecard_image|
              @course.scorecard_images.create(photo: scorecard_image)
            }
          end
        end
      end
      if params[:videos].present?
        Thread.new do
          params[:videos].each do |index, video_params|
            video_details = {title: video_params[:title], description: video_params[:description]}
            course_video = @course.videos.create(title: video_params["title"], description: video_params["description"])
            course_video.video = video_params[:video]
            course_video.thumbnail_image = video_params[:thumbnail_image]
            course_video.save
          end
        end
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
        if params[:course_scorecard].present?
          params[:course_scorecard].each do |scorecard_id, scorecard_params|
            scorecard = ScoreCard.find(scorecard_id)
            scorecard.tee_name = scorecard_params[:tee_name]
            scorecard.color = scorecard_params[:color]
            scorecard.rating = scorecard_params[:total_rating]
            scorecard.slope = scorecard_params[:total_slope]
            scorecard.save
            scorecard_params[:holes].each do |hole_num, hole_scorecard_params|
              hole = @course.holes.find_by(hole_num: hole_num)
              hole.yardages.find_by(score_card_id: scorecard.id).update(yards: hole_scorecard_params[:yardges])
              hole.pars.find_by(score_card_id: scorecard.id).update(par: hole_scorecard_params[:par])
              hole.hcps.find_by(score_card_id: scorecard.id).update(hcp: hole_scorecard_params[:hcp])
            end
          end
        end
        if params[:score_cards].present?
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
        Thread.new do 
          if params[:images]
            params[:images].each { |image|
              @course.course_images.create(photo: image)
            }
          end
          if params[:course_video].present?
            params[:course_video].each do |video_id, vid_params|
              video = Video.find(video_id)
              video.update(title: vid_params[:title], description: vid_params[:description])
            end
          end
          if params[:videos].present?
            params[:videos].each do |index, video_params|
              if video_params[:video].present?
                course_video = @course.videos.create(title: video_params["title"], description: video_params["description"])
                course_video.video = video_params[:video]
                course_video.thumbnail_image = video_params[:thumbnail_image]
                course_video.save
              end
            end
          end
          if params[:scorecard_images].present?
            params[:scorecard_images].each { |scorecard_image|
              @course.scorecard_images.create(photo: scorecard_image)
            }
          end
        end
        format.html { redirect_to admin_resort_courses_path(@course.resort), notice: 'Course was successfully updated.' }
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
    @hole = Hole.find(params[:hole][:id])
    @hole.update(hole_params)
    @course = @hole.course
    Thread.new do
      if params[:hole][:hole_images].present?
        params[:hole][:hole_images].each do |image|
          @hole.hole_images.create(image: image)
        end
      end
      if params[:hole][:video].present?
        hole_video = @hole.build_video(video: params[:hole][:video])
        @hole.video.save
      end
    end
    # course = Course.find(params[:course_id])
    # all_hole_details = []
    # params[:holes].each do |hole_id, hole_params|
    #   hole_details = {hole_id: hole_id, description: hole_params[:description]}
    #   if hole_params[:video].present?
    #     hole_video = hole_params[:video].tempfile
    #     hole_video_file = File.join("public", "hole#{hole_id}_video_#{hole_params[:video].original_filename}")
    #     FileUtils.cp hole_video.path, hole_video_file
    #     hole_details[:video_file_path] = hole_video_file
    #   end
    #   if hole_params[:cover].present?
    #     hole_cover = hole_params[:cover].tempfile
    #     hole_cover_file = File.join("public", "hole#{hole_id}_cover_#{hole_params[:cover].original_filename}")
    #     FileUtils.cp hole_cover.path, hole_cover_file
    #     hole_details[:cover_file_path] = hole_cover_file
    #   end
    #   if hole_params[:map].present?
    #     hole_map = hole_params[:map].tempfile
    #     hole_map_file = File.join("public", "hole#{hole_id}_map_#{hole_params[:map].original_filename}")
    #     FileUtils.cp hole_map.path, hole_map_file
    #     hole_details[:map_file_path] = hole_map_file
    #   end

    #   hole_images_paths = []
    #   if hole_params[:images].present?
    #     hole_params[:images].each_with_index do |image, index|
    #       hole_image = image.tempfile
    #       hole_image_file = File.join("public", "hole#{hole_id}_image#{index+1}_#{image.original_filename}")
    #       FileUtils.cp hole_image.path, hole_image_file
    #       hole_images_paths << hole_image_file
    #     end
    #   end
    #   hole_details[:hole_images_paths] = hole_images_paths
    #   all_hole_details << hole_details
    # end
    # UploadHoleMediaWorker.perform_async(all_hole_details)
    # if params[:commit] == "Save"
    #   redirect_to admin_courses_path
    # else
    #   @resort = course.resort
    #   @resort.courses.build
    #   render :new
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id]) rescue nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :bio, :color_selector, :resort_id)
    end

    def resort_params
      params.require(:resort).permit(:name, :resort_type, :website, :phone_num, :network_id, location_attributes: [:town,:state, :lat, :lng], courses_attributes: [:name, :bio, :color_selector, :cover])
    end
  def hole_params
    params.require(:hole).permit(:image, :map, :description)
  end
end
