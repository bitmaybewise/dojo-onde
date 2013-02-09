class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      User.login(@user.email, @user.password)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render action: :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to root_path
    else
      render :edit
    end
  end
end
