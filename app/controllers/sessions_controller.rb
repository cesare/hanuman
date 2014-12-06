class SessionsController < ApplicationController
  def create
    auth = request.env['omniauth.auth']
    # TODO find or generate person and user
    redirect_to '/'
  end

  def destroy
    reset_session
    redirect_to '/'
  end
end
