require 'test_helper'

module Posts
  class PostCommentsControllerTest < ActionDispatch::IntegrationTest
    setup do
      @post = posts(:one)
      @post_comment = post_comments(:one)
    end

    test "should get new" do
      get new_post_post_comment_url(@post)
      assert_response :success
    end

    test "should create post_comment with valid params" do
      assert_difference('PostComment.count') do
        post post_post_comments_url(@post), params: { post_comment: { body: 'New comment', post_id: @post.id } }
      end
      assert_redirected_to post_path(@post)
      assert_equal 'Comment was successfully created.', flash[:notice]
    end

    test "should get edit" do
      get edit_post_post_comment_url(@post, @post_comment)
      assert_response :success
    end

    test "should update post_comment with valid params" do
      patch post_post_comment_url(@post, @post_comment), params: { post_comment: { body: 'Updated comment' } }
      assert_redirected_to post_path(@post_comment.post)
      assert_equal 'Comment was successfully updated.', flash[:notice]
    end

    test "should destroy post_comment" do
      assert_difference('PostComment.count', -1) do
        delete post_post_comment_url(@post, @post_comment)
      end
      assert_redirected_to post_url(@post)
      assert_equal 'Comment was succesfully destroyed', flash[:notice]
    end
  end
end