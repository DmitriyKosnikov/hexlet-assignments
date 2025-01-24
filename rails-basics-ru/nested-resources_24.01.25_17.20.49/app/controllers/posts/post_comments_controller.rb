module Posts
  class PostCommentsController < ApplicationController
    before_action :set_post, only: %i[ index new create ]
    before_action :set_post_comment, only: %i[ show edit update destroy ]

    # GET /post_comments or /post_comments.json
    def index
      @post_comments = @post.post_comments
    end

    # GET /post_comments/1 or /post_comments/1.json
    def show
    end

    # GET /post_comments/new
    def new
      @post_comment = @post.post_comments.build
    end

    # GET /post_comments/1/edit
    def edit
    end

    # POST /post_comments or /post_comments.json
    def create
      @post_comment = @post.post_comments.build(post_comment_params)

      if @post_comment.save
        redirect_to post_path(@post), notice: "Comment was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /post_comments/1 or /post_comments/1.json
    def update
      if @post_comment.update(post_comment_params)
        redirect_to post_path(@post_comment.post), notice: "Comment was successfully updated."
      else
        render :edit, status: :unprocessable_entity, notice: "Что-то не так!"
      end
    end

    # DELETE /post_comments/1 or /post_comments/1.json
    def destroy
      @post_comment.destroy!

      redirect_to post_url(params[:post_id]), notice: "Comment was succesfully destroyed"
    end

    private
      def set_post
        @post = Post.find(params[:post_id])
      end
      # Use callbacks to share common setup or constraints between actions.
      def set_post_comment
        @post_comment = PostComment.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_comment_params
        params.require(:post_comment).permit(:body, :post_id)
      end
  end
end