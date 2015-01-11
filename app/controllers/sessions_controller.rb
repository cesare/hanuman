class SessionsController < ApplicationController
  def new
    @auth_origin_uri = session.delete(:auth_origin_uri)
  end

  def create
    user = SigninService.signin auth_info
    session[:person_id] = user.person_id

    redirect_to origin_uri || root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth_info
    auth = request.env['omniauth.auth']
    {
      provider: auth['provider'],
      uid: auth['uid'].to_s,
      name: auth['info']['name'],
      email: auth['info']['email'],
    }
  end

  def origin_uri
    uri = request.env['omniauth.origin']

    return nil unless uri =~ /\A\//
    uri
  end
end
