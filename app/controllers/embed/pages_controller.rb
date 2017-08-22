class Embed::PagesController < ApplicationController
  before_action :set_course, only: [:show]
  # after_filter :allow_iframe, only: [:show, :awesome_embed]
  after_action :set_version_header
  # layout "embed", only: [:show]
  layout "embed"

  def show
   

    @job = "547"
    
    @course = Course.find(params[:id])
    @xh = @course.holes
    
    @holes = @course.holes.sort_by{ |m| m.hole_num }

   

  end

  def hole_by_hole
    @hole=Hole.find(params[:id])
    @job = "698" 
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
