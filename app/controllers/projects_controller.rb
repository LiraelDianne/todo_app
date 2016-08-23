class ProjectsController < ApplicationController
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
    if @project.valid?
      params[:project][:team].each do |user_id| 
        @user = User.find(user_id)
        @user.projects.
  end

  def show
  end

  def edit
  end

  def update
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
