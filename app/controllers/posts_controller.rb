class PostsController < ApplicationController
    before_action :authenticate_user!, only: %i[ new create edit update destroy ]
    before_action :set_post, only: %i[ show edit update destroy ]
    before_action :authorize_user!, only: %i[ edit update destroy ]

    def index
        @posts = Post.ordered.with_authors
    end
    
    def new
        @post = Post.new
    end

    def show
    end

    def edit
    end

    def update
        if(@post.update(post_params))
            redirect_to @post
        else
            render 'edit'
        end
    end

    def create
        @post = Post.new(post_params)
        
        @post.author = current_user

        if(@post.save)
            redirect_to @post
        else
            render 'new'
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path
    end

    private 
    def set_post
        @post = Post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body)
    end

    def authorize_user!
        return if @post.author_id == current_user.id

        redirect_to :posts, alert: 'Access denied'
    end
end
