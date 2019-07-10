class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.commenter = current_user
        @comment.post = Post.find(params[:comment][:post_id])
        if @comment.save
            if params[:timeline]
                redirect_to posts_path
            else 
                redirect_to user_path(@comment.post.author)
            end
            flash[:notice] = "Succesfuly commented"
        else
            render 'new'
        end
    end

    def destroy
        comment = Comment.find(params[:id])
        user = comment.post.author
        comment.destroy
        redirect_to user_path(user)
    end

    def dest
        comment = Comment.find(params[:id])
        comment.destroy
        redirect_to posts_path
    end

    private

    def comment_params
        params.require(:comment).permit(:body)
    end

end
