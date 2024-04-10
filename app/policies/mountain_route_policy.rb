class MountainRoutePolicy < ApplicationPolicy
  attr_reader :user, :mountain_route

  def initialize(user, mountain_route)
    @user = user
    @mountain_route = mountain_route
  end

  def index?
    user
  end

  def new?
    user
  end

  def show?
    user
  end

  def update?
    user && user.id == mountain_route.user_id || admin?
  end

  def edit?
    user && user.id == mountain_route.user_id || admin?
  end

  def create?
    user
  end

  def destroy?
    user && user.id == mountain_route.user_id || admin?
  end
end
