class LikesController < ApplicationController
  def create
    like = Like.new(liked_post_id: params[:like][:post_id],liker: current_user)
    user = User.find(params[:like][:user_id])
    if like.save
      if params[:like][:source] == 'profile'
        redirect_to user_path(user)      
        flash[:notice] = "Liked!"
      else 
        redirect_to posts_path
        flash[:notice] = "Liked!"
      end
    else
        render 'new'
    end
  end

  def delete
    like = Like.find(params[:id])    
    user = like.liked_post.author   
    like.destroy   
  end
  
  def destroy
    like = Like.find(params[:id])    
    user = like.liked_post.author   
    like.destroy   
    if params[:source] === 'timeline'
      redirect_to posts_path
    else
      redirect_to user_path(user)
    end
  end
end
