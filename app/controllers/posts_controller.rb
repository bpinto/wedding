class PostsController < ApplicationController
  before_filter :protection, except: :create

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    Post.create post_params

    redirect_to root_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_params)

    redirect_to root_path
  end

  private

  def protection
    if params[:protection] != 'biancaebruno'
      redirect_to root_path
    end
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
end
