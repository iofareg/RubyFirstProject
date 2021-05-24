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
        @comment.destroy
        # I found the solution to redirect to previous page here
        # https://stackoverflow.com/questions/2139996/how-to-redirect-to-previous-page-in-ruby-on-rails
        session[:return_to] ||= request.referer
        redirect_to session.delete(:return_to)
    end
    private def comment_params
        params.require(:comment).permit(:body)
    end
end
