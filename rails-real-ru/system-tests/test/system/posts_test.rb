# frozen_string_literal: true

require 'application_system_test_case'

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
  end
  test 'visiting posts page' do
    visit posts_path

    assert_selector 'h1', text: 'Posts'
  end

  test 'visiting the post page' do
    visit posts_path
    find_link('Show', href: post_path(@post)).click

    assert_selector 'h1', text: @post.title
  end

  test 'creating new post' do
    visit posts_path
    click_on 'New Post'

    fill_in 'Title', with: @post.title
    fill_in 'Body', with: @post.body

    click_on 'Create Post'
    assert_text 'Post was successfully created.'
  end

  test 'updating the post' do
    visit posts_path
    find_link(href: edit_post_path(@post)).click

    fill_in 'Body', with: @post.title

    click_on 'Update Post'
    assert_text 'Post was successfully updated.'
  end

  test 'destroying the post' do
    visit posts_path
    find_link('Destroy', href: post_path(@post)).click

    accept_confirm

    assert_text 'Post was successfully destroyed.'
  end
end
