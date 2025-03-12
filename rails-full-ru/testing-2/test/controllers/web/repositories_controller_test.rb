# frozen_string_literal: true

require 'test_helper'

class Web::RepositoriesControllerTest < ActionDispatch::IntegrationTest
  # BEGIN
  setup do
    @repo_url = 'https://api.github.com/repos/octocat/Hello-World'
  end
  test "should create repository" do
    data = JSON.parse(load_fixture('files/response.json'))
    stub_request(:any, @repo_url).to_return(status: 200, body: data.to_json, headers: { 'Content-Type' => 'application/json' } )

    post repositories_url, params: { repository: { link: @repo_url } }
    repo = Repository.last
    assert_redirected_to repository_url(repo)
    debugger
    assert_equal data["html_url"], repo.link
    assert_equal data["owner"]["login"], repo.owner_name
    assert_equal data["name"], repo.repo_name
    assert_equal data["description"], repo.description
    assert_equal data["default_branch"], repo.default_branch
    assert_equal data["watchers_count"], repo.watchers_count
    assert_equal data["language"], repo.language
    assert_equal data["created_at"], repo.repo_created_at.iso8601
    assert_equal data["updated_at"], repo.repo_updated_at.iso8601
  end
  # END
end
