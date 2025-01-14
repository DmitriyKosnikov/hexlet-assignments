class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      #flash[:success] = 'Новая задача успешно создана!'
      redirect_to task_path(@task)
    else
      flash.now[:alert] = @task.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'задача успешно изменена'
      redirect_to task_url(@task)
    else
      flash[:failure] = 'Не получается сохранить изменения'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private

  def task_params
    params.required(:task).permit(:name, :status, :creator, :completed, :description, :performer)
  end
end
