class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_tag, only: [:show, :destroy]

  def create
    @tag = Tag.new(tag_params)
    @tag.video_id = params[:video_id]
    @flash_class = "alert alert-success"
    if @tag.save
      @video = @tag.video
      @message = "Tag added successfully."
    else
      @message = "Something went wrong, Tag was not added."
      @flash_class = "alert alert-danger"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @video = @tag.try(:video)
    @tag.destroy
  end

  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:tag, :time, :id)
    end

end