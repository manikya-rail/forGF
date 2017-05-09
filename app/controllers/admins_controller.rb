class AdminsController < ApplicationController
    before_action :authenticate_admin!

    def create_course
        render '/admin/create_course'
    end

    def courses
        
    end

    def frames
        
    end

    def users
        
    end
    
end