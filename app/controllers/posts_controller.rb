class PostsController < ApplicationController

    
    def create
        @post = Post.new(post_params)
        @post.author = current_user
        if @post.save
            redirect_to user_path(current_user)
            flash[:notice] = "Post Created!"
        else
            render 'new'
        end
    end


    private

    def post_params
        params.require(:post).permit(:title, :body)
    end


end
