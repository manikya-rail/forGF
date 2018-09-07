class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  # SG - not used
  # before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end
  # SG - unused action
  # def show
  # end

  private
    # SG - not used
    # def set_user
    #   @user = User.find(params[:id])
    # end
    def user_params
      params.require(:user).permit(:name, :created_at, :email)
    end
end
