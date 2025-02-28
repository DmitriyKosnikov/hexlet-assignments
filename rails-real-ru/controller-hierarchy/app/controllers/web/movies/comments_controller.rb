class Web::Movies::CommentsController < Web::Movies::ApplicationController
  def index
    @comments = resource_movie.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = resource_movie.comments.build(comment_params)

    if @comment.save
      redirect_to movie_comments_path(resource_movie)
    else
      render :new
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      redirect_to movie_comments_path(resource_movie)
    else
      render :edit
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy!
    redirect_to movie_comments_path(resource_movie)
  end

  private

  def comment_params
    params.require(:comment).permit(%i[body])
  end
end