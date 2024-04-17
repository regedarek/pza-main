class PasswordMailer < ApplicationMailer
  def reset
    @token = params[:token]
    @user = params[:user]

    mail to: params[:user].email
  end
end
