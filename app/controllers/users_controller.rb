class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      User.login(@user.email, @user.password)
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @user = current_user
    @user_providers = @user.providers_by_authentications
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: t('users.update.success')
    else
      render :edit
    end
  end

  def password
    @user = current_user
  end

  def change_password
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path(@user), notice: t('users.change_password.success')
    else
      render :password
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
