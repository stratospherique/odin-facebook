class LikesController < ApplicationController
  def create
    like = Like.new(liked_post_id: params[:like][:post_id],liker: current_user)
    user = User.find(params[:like][:user_id])
    if like.save
      redirect_to user_path(user)
      flash[:notice] = "Succesfuly commented"
    else
        render 'new'
    end
  end
end
