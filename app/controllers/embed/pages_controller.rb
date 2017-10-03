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
        gon.videos_urls << hole.video.video  if hole.video.present?
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
    
    @course = Course.find(params[:id])
    
    @holes = @course.holes.sort_by{ |m| m.hole_num }

    @holes.each do |hole|
        gon.hole_num << hole.hole_num if hole.video.present?
        gon.videos << hole.video  if hole.video.present?
        gon.videos_urls << hole.video.video  if hole.video.present?
        # hole.video.present? ? (gon.videos_urls << hole.video.video) : (gon.videos_urls << "http://s3-us-west-2.amazonaws.com/fore92/courses/videos/000/000/012/original/missing.mp4?1506746983")
        gon.tags << hole.video.tags  if hole.video.present?
        gon.par << hole.par if hole.video.present?
        gon.yard << hole.yards if hole.video.present?
        gon.mhcp << hole.mhcp if hole.video.present?
        gon.image << hole.image_file_name if hole.video.present?
        gon.image_urls << hole.image.url if hole.video.present?

    end

  end

  def hole_by_hole
    @hole=Hole.find(params[:id])
  end

  def course_home
    @course=Course.find(params[:id])
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
