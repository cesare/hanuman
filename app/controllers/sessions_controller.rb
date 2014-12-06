class SessionsController < ApplicationController
  def create
    user = SigninService.signin auth_info
    session[:person_id] = user.person_id

    redirect_to '/'
  end

  def destroy
    reset_session
    redirect_to '/'
  end

  private

  def auth_info
    auth = request.env['omniauth.auth']
    {
      provider: auth['provider'],
      uid: auth['uid'].to_s,
      name: auth['info']['name'],
    }
  end
end
