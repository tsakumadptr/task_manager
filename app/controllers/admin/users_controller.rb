class Admin::UsersController < ApplicationController

  before_action :auth_user
  before_action :auth_admin

  def auth_admin
    if @current_user.admin != "true"
      flash[:notice] = "You don't have admin authority"
      redirect_to '/'
      return
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end


  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :admin)
    end


end
