class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      redirect_to dashboard_path, alert: exception.message
    else
      redirect_to root_path, alert: exception.message
    end
  end

  if Rails.env.production?
    rescue_from Exception do |exception|
      ExceptionMailer.exception_email(exception, current_user).deliver
      render template: false, file: 'public/500.html', status: 500
    end
  end

end
