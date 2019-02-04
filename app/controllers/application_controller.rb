class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, alert: "You are not authorized to view admin portal."
    end
  end
end
