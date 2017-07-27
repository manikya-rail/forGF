class Embed::PagesController < ApplicationController
  before_action :set_course, only: [:show]
  # after_filter :allow_iframe, only: [:show, :awesome_embed]
  after_action :set_version_header
  layout "embed", only: [:show]


  def show
    gon.videos = []
    gon.videos_urls = []
    gon.tags = []
    gon.par = []
    gon.yard = []
    gon.mhcp = []

    @holes=@course.holes
    
    @course.holes.each do |hole|
        gon.videos << hole.video  if hole.video.present?
        gon.videos_urls << hole.video.video  if hole.video.present?
        gon.tags << hole.video.tags  if hole.video.present?
        gon.par << hole.par if hole.video.present?
        gon.yard << hole.yards if hole.video.present?
        gon.mhcp << hole.mhcp if hole.video.present?
    end

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
