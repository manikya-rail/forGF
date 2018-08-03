class Admin::HolesController < ApplicationController
  before_action :set_hole, only: [:show, :edit, :update, :destroy, :remove_image, :remove_map, :remove_logo_image, :hole_images]

  # GET /holes
  # GET /holes.json
  def index
    @holes = Hole.all
  end

  # GET /holes/1
  # GET /holes/1.json
  def show
  end

  # GET /holes/new
  def new
    @hole = Hole.new
  end

  # GET /holes/1/edit
  def edit
  end

  # POST /holes
  # POST /holes.json
  def create
    @hole = Hole.new(hole_params)

    respond_to do |format|
      if @hole.save
        format.html { redirect_to @hole, notice: 'Hole was successfully created.' }
        format.json { render :show, status: :created, location: @hole }
      else
        format.html { render :new }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /holes/1
  # PATCH/PUT /holes/1.json
  def update
    respond_to do |format|
      if @hole.update(hole_params)
        format.html { redirect_to @hole, notice: 'Hole was successfully updated.' }
        format.json { render :show, status: :ok, location: @hole }
      else
        format.html { render :edit }
        format.json { render json: @hole.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /holes/1
  # DELETE /holes/1.json
  def destroy
    @hole.destroy
    respond_to do |format|
      format.html { redirect_to admin_holes_url, notice: 'Hole was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_logo_hyperlink
    if params[:copy_all] == "true"
      Hole.joins(:course).where(courses: {id: params[:course_id]}).map{|h| h.logo_hyperlink = params[:hyperlink]; h.save}
    else
      @hole = Hole.find(params[:hole_id])
      @hole.logo_hyperlink = params[:hyperlink]
      @hole.save
    end
    render :json => {status: 'success'}, :layout => false
  end

  def add_logo_image
    @hole = Hole.find(params[:hole][:hole_id])

    if @hole.update(hole_params)
      redirect_to admin_course_path(@hole.course), notice: 'Image was successfully uploaded.'
    else
      redirect_to admin_course_path(@hole.course), notice: 'Image not uploaded.'
    end
  end

  def remove_logo_image
    @hole.logo_image.destroy
    respond_to do |format|
      format.html { redirect_to :back , notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_image
    @hole = Hole.find(params[:hole][:hole_id])
    if @hole.update(hole_params)
      redirect_to admin_course_path(@hole.course), notice: 'Image was successfully uploaded.'
    else
      redirect_to admin_course_path(@hole.course), notice: 'Image not uploaded.'
    end
  end

  # put /holes/1
  # put /holes/1.json
  def remove_image
    @hole.image.destroy
    @hole.update(image: nil)
    respond_to do |format|
      format.html { redirect_to :back , notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_map
    @hole = Hole.find(params[:hole][:hole_id])

    if @hole.update(hole_params)
      redirect_to admin_course_path(@hole.course), notice: 'Map was successfully uploaded.'
    else
      redirect_to admin_course_path(@hole.course), notice: 'Map not uploaded.'
    end
  end

  # put /holes/1
  # put /holes/1.json
  def remove_map
    @hole.map.destroy
    @hole.update(map: nil)
    respond_to do |format|
      format.html { redirect_to :back , notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_yardages
    @hole = Hole.find(params[:yardages][:hole_id])

    @hole.course.score_cards.each do |tees|
      if @hole.yardages.where(score_card_id: tees.id).present?
        @hole.yardages.where(score_card_id: tees.id).first.update(yards: params[:yardages][:"#{tees.id}".to_sym])
        # redirect_to :back, notice: 'Tees yards successfully updated.'
      else
        @yard = @hole.yardages.new
        @yard.score_card_id = tees.id
        @yard.yards = params[:yardages][:"#{tees.id}".to_sym]
        @yard.save
      end
    end
    # if @hole.update(hole_params)
      redirect_to :back, notice: 'Tees yards successfully uploaded.'
    # else
    #   redirect_to admin_course_path(@hole.course), notice: 'Map not uploaded.'
    # end
  end

  def add_hole_image
    @hole = Hole.find(params[:hole][:hole_id])

    # if @hole.update(hole_params)
    if @hole.present?  
      if params[:images]
        params[:images].each { |image|
          @hole.hole_image.create(image: image)
        }
        redirect_to admin_course_path(@hole.course), notice: 'Images were successfully uploaded.'
      end
        
    else
        redirect_to admin_course_path(@hole.course), notice: 'Images not uploaded.'
    end
  end

  # put /holes/1
  # put /holes/1.json
  def remove_hole_image
    @holeimage = HoleImage.find(params[:id])
    @hole=@holeimage.hole
    if @holeimage.destroy
      respond_to do |format|
        format.html { redirect_to :back , notice: 'Gallery image was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  end

  def get_yardages
    @hole = Hole.find(params[:hole_id])
    @score_cards = @hole.course.score_cards
    @yardages = @hole.yardages.where(score_card_id: @score_cards.pluck(:id))
  end

  def hole_images
    @hole_images = @hole.hole_images    
  end

  def set_images_rank
    params[:hole_image].each do |hole_image_id, rank|
      hole_image = HoleImage.find(hole_image_id)
      hole_image.update(rank: rank)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hole
      @hole = Hole.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hole_params
      params.require(:hole).permit(:par, :yards, :mhcp, :whcp, :image, :map, :logo_image)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def yard_params
      params.require(:yardages).permit!
    end

end
