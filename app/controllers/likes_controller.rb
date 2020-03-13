class LikesController < ApplicationController
  def create
    like = Like.new(liked_post_id: params[:like][:post_id],liker: current_user)
    if like.save
      if params[:source] == 'timeline'
        redirect_to posts_path
        flash[:notice] = "Liked!"
      else 
        puts params[:source]
        user = User.find(params[:source])
        redirect_to user_path(user)      
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
    like.destroy   
    if params[:source] === 'timeline'
      redirect_to posts_path
    else
      user = User.find(params[:source])
      redirect_to user_path(user)
    end
  end
end
