class LikesController < ApplicationController
  def create
    like = Like.new(liked_post_id: params[:like][:post_id],liker: current_user)
    user = User.find(params[:like][:user_id])
    if like.save
      redirect_to user_path(user)
      flash[:notice] = "Liked!"
    else
        render 'new'
    end
  end

  def destroy
    like = Like.find(params[:id])
    user = like.liked_post.author
    like.destroy
    redirect_to user_path(user)
  end
end
