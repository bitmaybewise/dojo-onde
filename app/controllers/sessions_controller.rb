class SessionsController < ApplicationController
  def new; end

  def create
    email, password = params[:email], params[:password]
    user = User.login(email, password)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_sessions_path, alert: "Dados inválidos!"
    end
  end

  def social
    oauth = OAuthData.new(request.env["omniauth.auth"])
    user  = Authentication.from_oauth!(oauth, current_user)
    session[:user_id] = user.id
    redirect_to edit_user_path(current_user)
  end

  def failure
    redirect_to login_path, notice: t('sessions.social.failure')
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
