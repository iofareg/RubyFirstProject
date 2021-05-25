class CommentsController < ApplicationController
    before_action :authenticate_user!, only: %i[ new create edit update destroy ]
    
    def create
        @post = Post.find(params[:post_id])
        #@comment = @post.comments.create(comment_params)
        @comment = Comment.new(comment_params)
        @comment.post = @post
        @comment.author = current_user
        @comment.save
        redirect_to post_path(@post)
    end
    def destroy
        
        @post = Post.find(params[:post_id])
        @comment = @post.comments.find(params[:id])
        if @comment.post.author == current_user || @comment.author == current_user || current_user.admin?
            @comment.destroy
            session[:return_to] ||= request.referer
            redirect_to session.delete(:return_to), notice: 'Comment deleted'
        else
            session[:return_to] ||= request.referer
            redirect_to session.delete(:return_to), alert: 'Access denied'
        end
    end
    private def comment_params
        params.require(:comment).permit(:body)
    end
end
