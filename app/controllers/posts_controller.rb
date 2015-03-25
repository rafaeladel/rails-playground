class PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.paginate(page: params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      @posts = Post.paginate(page: params[:page])
      @post = Post.new
      respond_to do |format|
        format.html { redirect_to posts_url}
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'posts/new' }
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
    @posts = Post.paginate(page: params[:page])
    respond_to do |format|
      format.html { redirect_to posts_url}
      format.js
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
