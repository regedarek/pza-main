class MountainRoutePolicy < ApplicationPolicy
  attr_reader :user, :mountain_route

  def initialize(user, mountain_route)
    @user = user
    @mountain_route = mountain_route
  end

  def index?
    true
  end

  def new?
    user
  end

  def show?
    true
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

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      case
      when user && user.admin?
        scope
      when user
        MountainRoute.includes(:partners)
          .where(hidden: false)
          .or(
            MountainRoute.includes(:partners).where(user_id: user.id)
          ).or(
            MountainRoute.includes(:partners).where(partners: { id: user.id })
          ).distinct
      else
        scope.where(hidden: false)
      end
    end

    private

    attr_reader :user, :scope
  end
end
