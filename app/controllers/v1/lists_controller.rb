class V1::ListsController < ApplicationController
  before_action :authenticate!
  before_action :set_list, only: [:show, :add_course]
  before_action :set_course, only: [:add_course]

  def show
    render :show, status: :ok
  end

  def create
    list = List.new(list_params)

    if list.save
        return head :ok
    else
        render json: {errors: list.errors.full_messages}, status: :failed
    end
  end

  def add_course
    @list.courses << @course

    if @list.save
        return head :ok
    else
        render json: {errors: @list.errors.full_messages}, status: :failed
    end
  end

  private
    def set_list
      @list = List.find(params[:id])
    end

    def set_course
      @course = Course.find(params[:list][:course_id])
    end

    def list_params
      params.require(:list).permit(:name, :user_id)
    end
end
