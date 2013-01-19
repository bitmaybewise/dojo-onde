# encoding: UTF-8
class SessionsController < ApplicationController
  def new
  end

  def create
    email, password = params[:email], params[:password]
    user = User.login(email, password)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_sessions_path, alert: "E-mail ou senha inválida!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
