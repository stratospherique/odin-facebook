class CommentsController < ApplicationController
    def create
        @comment = Comment.new(comment_params)
        @comment.user = current_user
        if @comment.save
            redirect_to user_path
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
