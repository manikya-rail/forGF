class V1::VideosController < ApplicationController
  before_action :authenticate!
  before_action :set_hole, only: [:show]

  def show
    @video = @hole.video    
  end

  private

    def set_hole
      @hole = Hole.find(params[:id])
    end

    def video_params
      params.permit(:id)
    end
end
