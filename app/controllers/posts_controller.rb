class PostsController < ApplicationController
    def index        
        @posts = []
        current_user.friends.each{|f| f.posts.each {|pi| @posts << pi}}
        current_user.posts.each { |post| @posts << post}
        @posts.sort!{|x, y| y.created_at <=> x.created_at }
        
    end
    
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
