class UsersController < ApplicationController
  before_action :require_login, except: [:welcome, :login, :create]

  def index
    @user = User.find(session[:user_id])
    @users = User.where.not(id: session[:user_id])
  end

  def welcome
    @user = User.new
  end

  def login
    user = User.find_by email: params[:user][:email]
    unless user && user.authenticate(params[:user][:password])
      flash[:login_error] = "Invalid email and password combination."
      redirect_to action: 'welcome'
    else
      session[:user_id] = user.id
      redirect_to '/home'
    end
  end

  def logout
    session.destroy
    redirect_to action: 'welcome'
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to '/home'
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to action: 'welcome'
    end
  end

  def show
    @user = User.find(params[:id])
    @tasks = @user.tasks
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.update(params[:id], first_name: params[:user][:first_name], last_name: params[:user][:last_name], email: params[:user][:email])
    unless @user.valid?
      flash[:errors] = @user.errors.full_messages
      redirect_to action: 'edit', id: @user.id
    else
      redirect_to action: 'show', id: @user.id
    end
  end

  def delete
    User.destroy(params[:id])
    redirect_to action: 'welcome'
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
