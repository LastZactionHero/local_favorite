class BlacklistUsersController < ApplicationController
  skip_before_filter :verify_authenticity_token
  authorize_resource class: false

  def index
    blacklist = current_user.blacklist_users
    render status: 200, json: blacklist.map{|bl| bl.username}
  end

  def create
    blacklist_user = BlacklistUser.create(
      user: current_user, 
      username: params[:username])

    if blacklist_user.valid?
      render status: 200, json: {username: blacklist_user.username}
    else
      render status: 400, json: {errors: blacklist_user.errors}
    end
  end

  def destroy
    blacklist_user = current_user.blacklist_users.find_by_username(params[:id])

    if blacklist_user
      blacklist_user.destroy
      render status: 200, json: {}
    else
      render status: 404, json: {}
    end
  end

end