class TasksController < ApplicationController
  before_action :identify_task, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'タスクが登録されました。'
      redirect_to tasks_url
    else
      flash.now[:danger] = 'タスクが登録できませんでした。'
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] = "タスクID:#{@task.id}を修正しました。"
      redirect_to tasks_url
    else
      flash.now[:danger] = 'タスクを修正できませんでした。'
      render :edit
    end
  end
  
  def destroy
    
    @task.destroy
    
    flash[:success] = 'タスクは削除されました。'
    redirect_to tasks_url
      
  end
  
  
  private
  
  def identify_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
end
