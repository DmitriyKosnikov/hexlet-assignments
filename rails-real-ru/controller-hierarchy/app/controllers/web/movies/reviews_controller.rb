class Web::Movies::ReviewsController < Web::Movies::ApplicationController
  def index
    @reviews = resource_movie.reviews
  end

  def new
    @review = Review.new
  end

  def create
    @review = resource_movie.reviews.build(review_params)

    if @review.save
      redirect_to movie_reviews_path(resource_movie)
    else
      render :new
    end
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to movie_reviews_path(resource_movie)
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_reviews_path(resource_movie)
  end

  private

  def review_params
    params.require(:review).permit(%i(body))
  end
end