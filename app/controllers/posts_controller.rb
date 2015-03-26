class PostsController < ApplicationController
  before_action :get_all, only: [:index, :create, :destroy]

  def index
    @post = Post.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @post = Post.new
      # render json: @posts
      respond_to do |format|
        format.html { redirect_to posts_url}
        format.json { render json: @posts }
      end
    else
      respond_to do |format|
        format.html { render 'posts/index' }
        format.js
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_url
    else
      render 'posts/edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url}
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

  def get_all
    @posts = Post.paginate(page: params[:page], per_page: 4)
  end
end
