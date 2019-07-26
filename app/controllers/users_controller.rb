class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @pending_friends = current_user.pending_friends
    @friends = current_user.friends
    @accept_friends = current_user.accept_friends
    @other_people = User.all - @friends - @pending_friends - @accept_friends - [current_user]
    @invite = current_user.invitations.build
  end


  def show
    @user = User.find(params[:id])
    @posts = @user.posts   
    @post = current_user.posts.build
    @friends = current_user.friends
    if @profile = current_user.profile 
      
    else
      @profile = current_user.build_profile
    end
  end

end
