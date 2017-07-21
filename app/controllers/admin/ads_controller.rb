class Admin::AdsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_course, only: [:show]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
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

  def add_image
    @hole = Hole.find(params[:hole][:hole_id])

    if @hole.update(hole_params)
      redirect_to admin_ad_path(@hole.course), notice: 'Image was successfully uploaded.'
    else
      redirect_to admin_ad_path(@hole.course), notice: 'Image not uploaded.'
    end
  end
  
  def holes
    @course = Course.find(params[:id])
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

end
