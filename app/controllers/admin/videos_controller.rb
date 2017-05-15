class Admin::VideosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_video, only: [:show]

  def create
    @video = Video.create(video_params)
    # @video.user = current_user

    if @video.save
      
      redirect_to admin_video_path(@video)
      flash[:success] = "Video uploaded successfully."
    else
      flash[:error] = "Failed to upload video."
      redirect :back
    end
  end

  def show
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:video)
    end

end