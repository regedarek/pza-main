class AppSettingPolicy < ApplicationPolicy
  attr_reader :user, :app_setting

  def initialize(user, app_setting)
    @user = user
    @app_setting = app_setting
  end

  def index?
    admin?
  end

  def new?
    admin?
  end

  def create?
    admin?
  end

  def edit?
    admin?
  end

  def update?
    admin?
  end

  def show?
    admin?
  end

  def destroy?
    admin?
  end
end
