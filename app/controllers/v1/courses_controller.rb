class V1::CoursesController < ApplicationController
  before_action :authenticate!
  before_action :set_user, only: [:add_user]
  before_action :set_course, only: [:show, :edit, :update, :destroy, :add_user]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
    if params[:state].present?
      state = params[:state]
      @courses = @courses.joins(:location).where(locations: {state: state})
    end

    render :index, status: :ok
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    render :show, status: :ok
  end

  # # GET /courses/new
  # def new
  #   @course = Course.new
  # end

  # # GET /courses/1/edit
  # def edit
  # end

  # # POST /courses
  # # POST /courses.json
  # def create
  #   @course = Course.new(course_params)

  #   respond_to do |format|
  #     if @course.save
  #       format.html { redirect_to admin_courses_path, notice: 'Course was successfully created.' }
  #       format.json { render :show, status: :created, location: @course }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @course.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /courses/1
  # # PATCH/PUT /courses/1.json
  # def update
  #   respond_to do |format|
  #     if @course.update(course_params)
  #       format.html { redirect_to @course, notice: 'Course was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @course }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @course.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /courses/1
  # # DELETE /courses/1.json
  # def destroy
  #   @course.destroy
  #   respond_to do |format|
  #     format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  def add_user
    course_user = CourseUser.new(course_id: @course.id, user_id: @user.id)

    if course_user.save
      return head :ok
    else
      render json: {errors: course_user.errors.full_messages}, status: :failed
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_user
      @user = User.find(params[:course][:user_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :course_type, :bio, :website, :phone_num, :total_par, :slope, :rating, :length, :logo, :cover,
          location_attributes: [:town,:state, :lat, :lng],
          networks_attributes: [:name],
          resorts_attributes: [:name],
          score_cards_attributes: [:tee_name, :color],
          holes_attributes: [:par, :yards, :mhcp, :whcp]
        )
    end
end
