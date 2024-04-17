class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Pagy::Backend
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  if Rails.env.development?
    include ActiveStorage::SetCurrent
    before_action do
      ActiveStorage::Current.url_options = {protocol: request.protocol, host: request.host, port: request.port}
    end
  end

  private

  def authenticate_user!
    return if user_signed_in?

    flash[:alert] = t("failure.unauthenticated")

    redirect_to new_session_path
  end

  def user_not_authorized
    flash[:alert] = t("pundit.not_authorized_html")

    redirect_to root_path
  end

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
