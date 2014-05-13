class UsersController < ApplicationController

  def toggle_automatic_favoriting
    enabled = params[:state] == 'true'
    current_user.set_automatic_favoriting!(enabled)

    render status: 200, json: {state: current_user.automatic_favoriting}
  end

end
