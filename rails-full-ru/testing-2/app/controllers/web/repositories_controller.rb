# frozen_string_literal: true

# BEGIN
require 'octokit'
# END

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    # BEGIN
    repository_url = permitted_params[:link]

    client = Octokit::Client.new

    octokit_repo = Octokit::Repository.from_url(repository_url)

    repostirory_data = client.repository(octokit_repo)

    @repository = Repository.new(
      link: repostirory_data.html_url,
      owner_name: repostirory_data.owner.name,
      repo_name: repostirory_data.name,
      description: repostirory_data.description,
      default_branch: repostirory_data.default_branch,
      watchers_count: repostirory_data.watchers_count,
      language: repostirory_data.language,
      repo_created_at: repostirory_data.created_at,
      repo_updated_at: repostirory_data.updated_at
    )

    if @repository.save
      redirect_to @repository, notice: 'success!'
    else
      render :new, status: :unprocessable_entity
    end
  rescue Octokit::NotFound
    redirect_to repositories_url, alert: 'Repository not found'
  rescue StandardError => e
    redirect_to repositories_url, alert: "An error occured: #{e.message}"
    # END
  end

  def edit
    @repository = Repository.find params[:id]
  end

  def update
    @repository = Repository.find params[:id]

    if @repository.update(permitted_params)
      redirect_to repositories_path, notice: t('success')
    else
      flash[:notice] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
