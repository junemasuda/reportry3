class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @reports = @user.reports.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Reportryにようこそ！！"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    if (current_user != @user)
      redirect_to root_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    if (current_user !=@user)
      redirect_to root_path
    end
    @user.attributes = params[:user]
    if @user.save
      redirect_to user_path(@user.id), notice:"保存できました！"
    else
      flash.now[:alert] = "保存に失敗しました・・・"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :free_contents)
  end
end