class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.commenter = current_user
        @comment.post = Post.find(params[:comment][:post_id])
        if @comment.save
            redirect_to user_path(@comment.post.author)
            flash[:notice] = "Succesfuly commented"
        else
            render 'new'
        end
    end


    private

    def comment_params
        params.require(:comment).permit(:body)
    end

end
