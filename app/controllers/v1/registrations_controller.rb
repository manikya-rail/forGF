class V1::RegistrationsController < ApplicationController 
    
    def create
        user = User.new(user_params)
        if user.save
            return head :ok
        else
            render json: {errors: user.errors.full_messages}, status: :failed
        end
    end

    private

    def user_params
      params.permit(:email, :first_name, :last_name, 
        :password, :password_confirmation)
    end
end
