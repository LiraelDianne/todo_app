class TasksController < ApplicationController
	before_action :require_login

	def create
		task = Task.new(task_params)
		if params(:id) 
			@project = Project.find(params[:id])
			task.user = User.find(params[:task][:user])
			if task.valid?
				@project.tasks.create(task_params)
			else
				flash[:errors] = @task.errors
			end
		else
			@user = User.find(session[:id])
			if task.valid?
				@user.tasks.create(task_params)
			else 
				flash[:errors] = @task.errors
			end
		end
		redirect_to(:back)
	end

	def edit
		@task = Task.find(params[:id])
	end

	def update
		@task = Task.find(params[:id])
		if @task.update(task_params)
			@task.user = User.find(params[:task][:user])
			if params[:task][:project]
				@task.project = Project.find(params[:task][:project])
			end
			redirect_to '/projects'
		else 
			flash[:errors] = @task.errors
			redirect_to action: 'edit', id: @task.id
		end
	end

	def delete
		task.destroy(params[:id])
		redirect_to(:back)
	end

	private
	def task_params
		params.require(:task).permit(:name, :due_date, :description)
	end
end
