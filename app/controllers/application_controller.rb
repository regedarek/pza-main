class ApplicationController < ActionController::Base
  include Pundit::Authorization

  private

  def current_user
    Current.user ||= authenticate_user_from_session
  end

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end
  helper_method :current_user

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?

  def login(user)
    Current.user = user
    reset_session
    session[:user_id] = user.id
  end

  def logout
    Current.user = nil
    reset_session
  end
end
