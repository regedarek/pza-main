class UsersController < ApplicationController
  def show
    @user = User.friendly.find(params[:id])
    authorize @user
  end

  def destroy
    @user = User.friendly.find(params[:id])
    authorize @user

    @user.destroy

    redirect_to root_path, notice: t('.destroyed')
  end
end
