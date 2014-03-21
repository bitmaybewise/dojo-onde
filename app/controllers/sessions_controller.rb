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
      redirect_to new_sessions_path, alert: "Dados inválidos!"
    end
  end

  def social
    oauth = OAuthData.new(request.env["omniauth.auth"])
    if current_user
      current_user.authentications
                  .create(uid: oauth.uid, provider: oauth.provider)
      redirect_to edit_user_path(current_user),
                  notice: "Sua conta do #{oauth.provider} foi vinculada"
    else
      user = User.find_by_email(oauth.email)
      auth = Authentication.find_by_uid_and_provider(oauth.uid, oauth.provider)
      if user
        user.authentications.create(uid: oauth.uid, provider: oauth.provider) if not auth
        session[:user_id] = user.id
      else
        session[:user_id] = if auth
                              auth.user.id
                            else
                              User.create_from_auth(oauth).id
                            end
      end
      redirect_to root_path
    end
  end

  def failure
    flash[:notice] = "Erro durante autenticação!" 
    redirect_to login_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
