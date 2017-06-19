class V1::SessionsController < ApplicationController
    before_action :authenticate!, only: [:destroy]


    def create
        @user = User.find_by_email params[:email]
        if @user&.valid_password?(params[:password])
            render :create, status: :created
        else
            head(:unauthorized)
        end
    end

    def destroy
        @user&.authentication_token = nil
        if @user.save
            head(:ok)
        else
            head(:unauthorized)
        end
    end

    private


end
