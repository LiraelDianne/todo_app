class UsersController < ApplicationController
  before_action :require_login, except: [:welcome, :login, :create]  

  def index
    @users = User.all
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
      redirect_to '/projects'
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
      redirect_to '/projects'
    else 
      flash[:errors] = @user.errors
      redirect_to action: 'welcome'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    unless @user.update(user_params)
      flash[:errors] = @user.errors
    end
    redirect_to '/projects'
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
