class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id]);
    @posts = @user.posts   
    @post = current_user.posts.build
    @friends = current_user.friends
  end




end
