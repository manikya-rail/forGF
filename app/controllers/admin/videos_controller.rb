class Admin::VideosController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_video, only: [:show, :destroy]

  def create
    @video = Video.create(video_params)
    @flash_class = "alert alert-success"
    @success = false
    if @video.save
      @success = true
      @message = "Video uploaded successfully."
    else
      @message = "Failed to upload video."
      @flash_class = "alert alert-danger"
    end

    respond_to do |format|
      format.js
    end

  end

  def show
    gon.video = @video
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:video, :hole_id)
    end

end
