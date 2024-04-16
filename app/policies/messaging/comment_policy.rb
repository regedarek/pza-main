class Messaging::CommentPolicy < ApplicationPolicy
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

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.where(hidden: false)
        .or(scope.where(user_id: user.id))
    end

    private

    attr_reader :user, :scope
  end
end
