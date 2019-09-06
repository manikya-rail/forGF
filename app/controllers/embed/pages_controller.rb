class Embed::PagesController < ApplicationController
  before_action :set_course, only: [:show]
  # after_filter :allow_iframe, only: [:show, :awesome_embed]
  after_action :set_version_header
  # layout "embed", only: [:show]
  layout "embed"
  layout "display", only: [:display]

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
    @videos_urls = gon.videos_urls
  end

  def display
    gon.videos_urls = []
    gon.image_urls = []
    @teename = []
    @course = Course.find(params[:id])
    @resort = @course.resort
    resolution = 'medium'.to_sym
    @course.playlist_items.each do |video|
      gon.videos_urls << video.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net').gsub("http", "https") if video.video.present?
      gon.image_urls << video.thumbnail_image.url.gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net').gsub("http", "https") if video.thumbnail_image.present?
    end
    @videos_urls = gon.videos_urls
    @holes = @course.holes.order("hole_num")
    @score_cards = @course.sorted_scorecards
    @course.score_cards.each do |scorecard|
      @teename << [scorecard.tee_name, scorecard.id, scorecard.color]
    end
    
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
    resolution = 'medium'.to_sym
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
    @videos_urls = gon.videos_urls
  end

  def course_home
    gon.videos_urls = []
    gon.image_urls = []
    @teename = []
    @course = Course.find(params[:id])
    resolution = 'medium'.to_sym
    # resolution = (is_mobile? ? 'mobile' : 'medium').to_sym
    @course.playlist_items.each do |video|
      gon.videos_urls << video.video.url(resolution).gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if video.video.present?
      gon.image_urls << video.thumbnail_image.url.gsub('s3-us-west-2.amazonaws.com/fore92', 'd1s5na5d5z3eyp.cloudfront.net') if video.thumbnail_image.present?
    end
    @videos_urls = gon.videos_urls
    @holes = @course.holes.order("hole_num")
    @score_cards = @course.sorted_scorecards
    @course.score_cards.each do |scorecard|
      @teename << [scorecard.tee_name, scorecard.id, scorecard.color]
    end
  end

  def update_tee_scorecard
    @scorecard = ScoreCard.find(params[:sid])
  end

  def awesome_embed
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end

    def set_version_header
      # response.set_header("X-Frame-Options", "ALLOWALL")
      response.headers.except! 'X-Frame-Options'
    end
end
