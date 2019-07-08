class ProfilesController < ApplicationController
    def create
        @profile = Profile.new(profile_params)
        @profile.user = current_user
        if @profile.save
            redirect_to user_path(current_user)
        else
            user_path(current_user)
        end
    end

    def update
        @profile = current_user.profile 
        if @profile.update(profile_params)
            redirect_to user_path(current_user)
        else
            redirect_to user_path(current_user)
        end
    end



    private

    def profile_params
        params.require(:profile).permit(:city, :state, :country, :gender, :birth_date, :phone_number)
    end

end
