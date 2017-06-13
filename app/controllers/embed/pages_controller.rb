class Embed::PagesController < ApplicationController
  before_action :set_course, only: [:show]

  def show
    gon.videos = []
    gon.videos_urls = []
    gon.tags = []
    @course.holes.each do |hole|
      gon.videos << hole.video if hole.video.present?
      gon.videos_urls << hole.video.video if hole.video.present?
      gon.tags << hole.video.tags if hole.video.present?
    end
  end

  private
    def set_course
      @course = Course.find(params[:id])
    end
end
