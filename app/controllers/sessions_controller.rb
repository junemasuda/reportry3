class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      flash[:info] = "ログインしました"
      redirect_to @user
    else
      flash[:danger] = 'Eメールかパスワードが間違っています'
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end