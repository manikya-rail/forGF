class V1::UsersController < ApplicationController
  before_action :authenticate!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    render :show, status: :ok
  end

  def update
    if @user.update(user_params)
        return head :ok
    else
        render json: {errors: user.errors.full_messages}, status: :failed
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:email, :first_name, :last_name,
        :password, :password_confirmation)
    end
end
