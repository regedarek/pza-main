class PasswordResetsController < ApplicationController
  before_action :set_user_by_token, only: %i[edit update]

  def new
  end

  def create
    if (user = User.find_by(email: params[:email]))
      PasswordMailer.with(
        user: user,
        token: user.generate_token_for(:password_reset)
      ).reset.deliver_now
    end

    redirect_to root_url, notice: t('password_resets.create.notice')
  end

  def edit
  end

  def update
    if @user.update(password_params)
      login(@user)

      redirect_to root_path, notice: t('password_resets.update.notice')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user_by_token
    @user = User.find_by_token_for(:password_reset, params[:token])
    redirect_to new_password_reset_path, alert: t('password_resets.update.alert') unless @user.present?
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
