class PasswordsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user
      user.send_password_reset
      redirect_to root_url, notice: "Email sent with password reset instructions."
    else
      redirect_to root_url, notice: "Email address not found."
    end
  end
end
