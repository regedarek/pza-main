class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)

    if @user.save
      login(@user)

      redirect_to root_path, notice: t(".success")
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
