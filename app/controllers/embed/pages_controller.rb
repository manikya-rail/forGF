class Embed::PagesController < ApplicationController
  before_action :set_course, only: [:show]
  # after_filter :allow_iframe, only: [:show, :awesome_embed]
  after_action :set_version_header
  # layout "embed", only: [:show]
  layout "embed"

  def show
    gon.hole_num = []
    gon.videos = []
    gon.videos_urls = []
    gon.tags = []
    gon.par = []
    gon.yard = []
    gon.mhcp = []
    gon.image = []
    gon.image_urls = []
    gon.description = []

    @job = "547"

    @course = Course.find(params[:id])
    @xh = @course.holes

    @holes = @course.holes.sort_by{ |m| m.hole_num }

    @holes.each do |hole|
      gon.hole_num << hole.hole_num if hole.video.present?
      gon.videos << hole.video  if hole.video.present?
      gon.videos_urls << hole.video.video if hole.video.present?
      gon.tags << hole.video.tags  if hole.video.present?
      gon.par << hole.par if hole.video.present?
      gon.yard << hole.yards if hole.video.present?
      gon.mhcp << hole.mhcp if hole.video.present?
      gon.image << hole.image_file_name if hole.video.present?
      gon.image_urls << hole.image.url if hole.video.present?
      gon.description << hole.description if hole.video.present?
    end
  end

  def display
    gon.videos_urls = []
    gon.image_urls = []

    @course = Course.find(params[:id])

    @holes = @course.holes.sort_by{ |m| m.hole_num }

    @par = []
    @yards = []
    @mhcp = []
    @teename = []
    @course.score_cards.each do |scorecard|
      @teename << [scorecard.tee_name, scorecard.id, scorecard.color]
    end
    @course.holes.sort_by(&:hole_num).each do |hole|
      @par << hole.par.to_i
      @yards << hole.yards.to_i
      @mhcp << hole.mhcp.to_i
    end
    resolution = (is_mobile? ? 'mobile' : 'medium').to_sym
    gon.videos_urls << @course.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if @course.video.present?
    gon.image_urls <<  @course.cover.url.gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if @course.cover.present?
  end

  def hole_by_hole
    gon.hole_num = []
    gon.videos = []
    gon.videos_urls = []
    gon.tags = []
    gon.par = []
    gon.yard = []
    gon.mhcp = []
    gon.image = []
    gon.image_urls = []
    gon.description = []

    @hole = Hole.find(params[:id])
    @course = Course.find(@hole.course_id)
    @course_color = Course.find(@hole.course_id).color_selector
    @holes = @course.holes.sort_by{ |m| m.hole_num }

    resolution = (is_mobile? ? 'mobile' : 'medium').to_sym
    @resolution = resolution
    @holes.each do |hole|
      gon.hole_num << hole.hole_num if hole.video.present?
      gon.videos << hole.video  if hole.video.present?
      gon.videos_urls << hole.video.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if hole.video.present?
      gon.tags << hole.video.tags  if hole.video.present?
      gon.par << hole.par if hole.video.present?
      gon.yard << hole.yards if hole.video.present?
      gon.mhcp << hole.mhcp if hole.video.present?
      gon.image << hole.image_file_name if hole.video.present?
      gon.image_urls << hole.image.url.gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if hole.video.present?
    end
  end

  def course_home
    gon.videos_urls = []
    gon.image_urls = []
    @course = Course.find(params[:id])
    @holes = @course.holes.sort_by{ |m| m.hole_num }
    @par = []
    @yards = []
    @mhcp = []
    @teename = []
    @course.score_cards.each do |scorecard|
      @teename << [scorecard.tee_name, scorecard.id, scorecard.color]
    end
    @course.holes.each do |hole|
      @par << hole.par.to_i
      @yards << hole.yards.to_i
      @mhcp << hole.mhcp.to_i
    end
    resolution = (is_mobile? ? 'mobile' : 'medium').to_sym
    gon.videos_urls << @course.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if @course.video.present?
    gon.image_urls <<  @course.cover.url.gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if @course.cover.present?
  end

  def update_tee_scorecard
    @course = Course.find(params["cid"])
    sorted_holes = @course.holes.sort{|a,b| a.hole_num <=> b.hole_num }
    @yards = []
    @par = []
    @mhcp = []
     @course.holes.each do |hole|
      @par << hole.par.to_i
      @mhcp << hole.mhcp.to_i
    end
    sorted_holes.each do |hole|
       @yards << (hole.try(:yardages).select{|m| m.score_card_id == params["sid"].to_i if m.score_card_id.present?}.first.present? ?  hole.try(:yardages).select{|m| m.score_card_id.present? ? m.score_card_id == params["sid"].to_i : 0}.first.yards : 0)
    end
    @total_yards = @yards.sum()
    @total_par  = @par.sum()
    scorecard = ScoreCard.find(params["sid"].to_i)
    @tee_rating = scorecard.try(:rating)
    @tee_slope = scorecard.try(:slope)
  end

  def awesome_embed
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def set_version_header
        # response.headers['X-Frame-Options'] = 'AllowAll'
        response.set_header("X-Frame-Options", "ALLOWALL")
    end
end
