class V1::PagesController < ApplicationController
    before_action :authenticate!

    def index
        render json: {welcome: "welcome"}, status: :ok
    end

    
end