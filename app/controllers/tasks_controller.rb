class TasksController < ApplicationController

  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find_by(id: params[:id])
    unless @task
      redirect_to root_path
    end
  end

  def new
    @task = Task.new
  end

  def show
    @task = Task.find( params[:id] )
  end

  def update
    task = Task.find_by(id: params[:id])
    redirect_to root_path unless task

    if task.update_attributes task_params
      redirect_to root_path
    else
      render :edit
    end
  end

  def create
    @task = Task.new(name: params[:task][:name], description: params[:task][:description], completion_date: params[:task][:completion_date])
    if @task.save #successful = @task.save, if successful
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    Task.find_by(id: params[:id]).delete
    redirect_to root_path
  end

  def toggle_complete
   task = Task.find_by(id: params[:id])

    if task.status
      task.status = false
      task.completion_date = nil
    elsif
      task.status = true
      task.completion_date = Date.today
    end
    task.save
    redirect_to root_path
  end

  private

  def task_params
    return params.require(:task).permit(:name, :description, :completion_date)
  end
end
