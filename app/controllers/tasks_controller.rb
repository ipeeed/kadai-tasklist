class TasksController < ApplicationController
  before_action :require_login
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  
  def index
    @tasks = current_user.tasks.all.page(params[:page]).per(2)
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    
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
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
  
end
