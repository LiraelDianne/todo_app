class TasksController < ApplicationController
	before_action :require_login

	def index
		@user = User.find(session[:user_id])
		@tasks = @user.tasks
	end

	def create
		task = Task.new(task_params)
		if params[:id]
			@project = Project.find(params[:id])
			user = User.find(params[:task][:user])
			if task.valid?
				@project.tasks.create(task_params)
				@project.tasks.last.update(user: user)
				if user == User.find(session[:user_id])
					render json: {status: 'successful', task: task, assigned_to: 'user'}
				else
					render json: {status: 'successful', task: task, assigned_to: 'team'}
				end
			else
				render json: {status: 'unsuccessful', error: @task.errors}
			end
		else
			@user = User.find(session[:id])
			if task.valid?
				@user.tasks.create(task_params)
				render json: {status: 'successful', task: task}
			else 
				render json: {status: 'unsuccessful', error: @task.errors}
			end
		end
	end

	def completed
		@user = User.find(session[:user_id])
		@tasks = @user.tasks.where(completed: true)
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(task_params)
			if params[:task][:user]
				@task.user = User.find(params[:task][:user])
			end
			if params[:task][:project]
				@task.project = Project.find(params[:task][:project])
			end
			render json: {status: 'successful', task_id: @task.id}
		else 
			render json: {status: 'unsuccessful', error: @task.errors}
		end
	end

	def delete
		task.destroy(params[:id])
		redirect_to(:back)
	end

	private
	def task_params
		params.require(:task).permit(:name, :due_date, :description, :completed)
	end
end
