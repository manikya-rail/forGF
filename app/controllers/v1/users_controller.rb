class V1::UsersController < ApplicationController
  before_action :authenticate!
  before_action :set_user, only: [:show, :edit, :update, :destroy, :lists]

  def index
  end

  def show
    if @user
      render :show, status: :ok
    else
      render json: {errors: "User not found"}, status: :failed
    end
  end

  def update
    if @user.update(user_params)
        return head :ok
    else
        render json: {errors: user.errors.full_messages}, status: :failed
    end
  end

  def lists
    render :lists, status: :ok
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :location, :picture, :gender, :home_courses, :handicap_value)
    end
end
