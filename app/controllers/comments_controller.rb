class CommentsController < ApplicationController
	def create
		@user = User.find(session[:user_id])
		@comment.new(comment_params)
		if @comment.valid?
			if params[:comment][:commentable_type] == "project"
				@user.comments.create(comment_params, commentable: Project.find(params[:comment][:commentable]))
			elsif params[:comment][:commentable_type] == 'task'
				@user.comments.create(comment_params, commentable: Task.find(params[:comment][:commentable]))
			end	
		else
			flash[:error] = @comment.error
		end
		redirect_to(:back)
	end
	
	private
	def comment_params
		params.require(:comment).permit(:content)
	end
end
