class ProjectsController < ApplicationController
  before_action :require_login

  def home
    # displays the logged-in user's projects and tasks
    @user = User.find(session[:user_id])
    @projects = @user.projects
    @tasks = @user.tasks
  end

  def new
    @users = User.where.not(id: session[:user_id])
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    @user = User.find(session[user_id])
    if @project.valid?
      @project.save
      @project.users.push(@user)
      params[:project][:team].each do |user_id|
        user = User.find(user_id)
        @project.users.push(user)
      end
    else
      flash[:errors] = @project.errors
      redirect_to action: 'new'
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project.find(params[:id])
    unless @project.update(project_params)
      flash[:errors] = @project.errors
      redirect_to action: 'edit', id: @project.id
    end
    redirect_to action: 'show', id: @project.id
  end

  def delete
    Project.destroy(params[:id])
    redirect_to action: 'home'
  end

  private
  def project_params
    params.require(:project).permit(:name, :description, :start_date, :end_date)
  end
end
