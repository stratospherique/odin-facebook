class InvitationsController < ApplicationController
    def create
        @invitation = Invitation.new(invitee: current_user, invited_id:params[:invitation][:invited])
        if @invitation.save
            redirect_to users_path
            flash[:notice] = "invitation send"
        else
            redirect_to users_path
            flash[:notice] = "Something went wrong i don't know what!!!"
        end
    end

    private

    def invitation_params
        params.require(:invitation).permit(:invitee, :invited)
    end


end
