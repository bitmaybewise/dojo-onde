# encoding: UTF-8

class UsersController < ApplicationController
  before_filter :require_login, only: [:edit, :update]

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
    user_id = params[:id]
    @user = if user_id == current_user.id
              User.find(user_id)
            else
              User.find(current_user.id)
            end
  end

  def update
    @user = User.find(params[:id]) 
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), notice: "Usuário alterado com sucesso."
    else
      render :edit
    end
  end

  def password
    @user = User.new(params[:user])
  end

  def change_password
    @user = User.find(current_user.id)
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path(@user), notice: "Senha alterada com sucesso!"
    else
      render :password
    end
  end
end
