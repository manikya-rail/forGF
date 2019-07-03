class Admin::CoursesController < ApplicationController
  #require 'fileutils'
  before_action :authenticate_admin!
  before_action :set_course, only: [:show, :edit, :update, :destroy, :get_course_images]
  # GET /courses
  # GET /courses.json

  def add_playlist_item
    @video_index = params["video_index"].to_i
    @from_edit = params[:from_edit].present? && params[:from_edit] == "true"
  end

  def add_scorecard
    @scorecard_index = params["scorecard_index"].to_i
    @from_edit = params[:from_edit].present? && params[:from_edit] == "true"
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
      @course = @resort.courses.create(name: courses_params[:name], bio: courses_params[:bio], color_selector: courses_params[:color_selector], cover: courses_params[:cover], transparent_logo: courses_params[:transparent_logo], logo_hyperlink: courses_params[:logo_hyperlink])
    end
    if @resort.save
      @course = @resort.courses.last if @course.nil?
      if @course.holes.blank?
        (1..18).each do |hole_num|
          @course.holes.create(hole_num: hole_num)
        end
      end
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
            hole = @course.holes.find_by(hole_num: hole_num)
            if score_card.id.present? && hole.present?
              yardage = score_card.yardages.find_or_create_by(hole_id: hole.id, yards: hole_params[:yardges])
              par = score_card.pars.find_or_create_by(hole_id: hole.id, par: hole_params[:par])
              hcp = score_card.hcps.find_or_create_by(hole_id: hole.id, hcp: hole_params[:hcp])
            end
          end
        end
      end
    else
      @errors = []
      @resort.errors.each do |field, details|
        @errors << "#{field.to_s} : #{details}"
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
            scorecard.rank = scorecard_params[:rank]
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
              slope: scorecard_params[:total_slope], rank: scorecard_params[:rank])
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
              video.update(title: vid_params[:title], description: vid_params[:description], rank: vid_params[:rank])
              video.video = vid_params[:video] if vid_params[:video].present?
              video.thumbnail_image = vid_params[:thumbnail_image] if vid_params[:thumbnail_image].present?
              video.save
            end
          end
          if params[:videos].present?
            params[:videos].each do |index, video_params|
              if video_params[:video].present?
                course_video = @course.videos.create(title: video_params["title"], description: video_params["description"], rank: video_params["rank"])
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
     CourseImage.find(params[:course_image_id]).delete
    end
    render :json => {status: 'success'}, :layout => false
  end

  def update_holes
    @hole = Hole.find(params[:hole][:id])
    @hole.update(hole_params)
    @course = @hole.course
    hole_details, hole_images_paths = {hole_id: params[:hole][:id]}, []
    if params[:hole][:hole_images].present? && params[:hole][:hole_images].reject{|a| a.blank?}.present?
      params[:hole][:hole_images].each_with_index do |image, index|
        FileUtils::mkdir_p "public/hole_#{params[:hole][:id]}"
        hole_image = image.tempfile
        hole_image_file = File.join("public", "hole_#{params[:hole][:id]}" , "#{image.original_filename}")
        FileUtils.cp hole_image.path, hole_image_file
        hole_images_paths << hole_image_file
      end
    end
    if params[:hole][:video].present?
      hole_video_obj = @hole.build_video(status: "processing")
      hole_video_obj.save
      FileUtils::mkdir_p "public/hole_#{params[:hole][:id]}"
      hole_video = params[:hole][:video].tempfile
      hole_video_file = File.join("public", "hole_#{params[:hole][:id]}", "#{params[:hole][:video].original_filename}")
      FileUtils.cp hole_video.path, hole_video_file
      hole_details[:video_id] = hole_video_obj.id
      hole_details[:video_file_path] = hole_video_file
    end
    hole_details[:hole_images_paths] = hole_images_paths
    UploadHoleMediaWorker.perform_async(hole_details) if hole_details[:video_file_path].present? || hole_details[:hole_images_paths].present?
  end

  def holes_list
    @course = Course.find(params[:course_id])
    @resort = @course.resort
  end

  def remove_scorecard_image
    ScorecardImage.find(params[:scorecard_image_id]).destroy
    render :json => {status: 'success'}, :layout => false
  end

  def remove_course_image
    CourseImage.find(params[:course_image_id]).destroy
    render :json => {status: 'success'}, :layout => false
  end

  def get_course_images
    @request_for = params[:image_type]
  end

  def set_images_rank
    @request_for = params[:request_for]
    if @request_for == "course"
      params[:course_image].each do |course_image_id, rank|
        course_image = CourseImage.find(course_image_id)
        @course = course_image.course if @course.nil?
        course_image.update(rank: rank)
      end
    else
      params[:scorecard_image].each do |scorecard_image_id, rank|
        scorecard_image = ScorecardImage.find(scorecard_image_id)
        @course = scorecard_image.course if @course.nil?
        scorecard_image.update(rank: rank)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id] || params[:course_id]) rescue nil
      if @course.present?
        return @course
      end
      redirect_to admin_courses_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :bio, :color_selector, :resort_id, :cover, :transparent_logo, :logo_hyperlink)
    end

    def resort_params
      params.require(:resort).permit(:name, :resort_type, :website, :phone_num, :network_id, location_attributes: [:town,:state, :lat, :lng], courses_attributes: [:name, :bio, :color_selector, :cover, :transparent_logo, :logo_hyperlinkg])
    end
  def hole_params
    params.require(:hole).permit(:image, :map, :description)
  end
end
