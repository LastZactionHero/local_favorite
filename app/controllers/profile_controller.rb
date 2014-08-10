class ProfileController < ApplicationController
  authorize_resource :class => false

  def index

  end

  def update
    current_user.update_attributes(params[:user].permit(:email))
    redirect_to dashboard_path
  end

end
