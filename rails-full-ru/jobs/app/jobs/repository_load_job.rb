class RepositoryLoadJob < ApplicationJob
  require 'octokit'

  queue_as :default

  def perform(repository_id)
    repository = Repository.find(repository_id)
    
    repository.try_fetch!

    client = Octokit::Client.new

    octokit_repo = Octokit::Repository.from_url(repository.link)

    repostirory_data = client.repository(octokit_repo)

    update_data = {
      link: repostirory_data.html_url,
      owner_name: repostirory_data.owner.login,
      repo_name: repostirory_data.name,
      description: repostirory_data.description,
      default_branch: repostirory_data.default_branch,
      watchers_count: repostirory_data.watchers_count,
      language: repostirory_data.language,
      repo_created_at: repostirory_data.created_at,
      repo_updated_at: repostirory_data.updated_at
    }

    if repository.update(update_data)
      repository.success_fetch!
    else
      repository.fail!
    end
  end
end
