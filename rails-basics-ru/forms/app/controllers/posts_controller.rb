class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = "Post has been saved"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      flash[:success] = "Post updated successfully"
      redirect_to @post
    else
      flash.now[:alert] = @post.errors.full_messages.join(", ")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.required(:post).permit(:title, :body, :summary, :published)
  end
end