class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session
  acts_as_token_authentication_handler_for User, fallback_to_devise: false
  helper_method :is_mobile?

  private

  def is_mobile?
    (request.user_agent =~ /\b(Android|iPhone|Windows Phone|Opera Mobi|Kindle|BackBerry|PlayBook)\b/i).present?
  end

    def authenticate!
        @user = User.find_by_email_and_authentication_token(authenticate_params[:email], authenticate_params[:token])
        unless @user
            return head :method_not_allowed
        end
    end

    def authenticate_params
      params.permit(:email, :token)
    end
end
