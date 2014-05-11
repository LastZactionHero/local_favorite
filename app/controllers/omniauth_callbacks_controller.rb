class OmniauthCallbacksController < ApplicationController

  def twitter
    omniauth = request.env['omniauth.auth']
    uid = omniauth.uid
    username = omniauth.info.nickname
    provider = omniauth.provider

    user = User.find_by_uid(uid)
    user ||= User.create(provider: provider, uid: uid, username: username)

    sign_in(user)
    redirect_to dashboard_path
  end

  def failure
    flash[:alert] = params.inspect
    redirect_to root_path
  end

end
