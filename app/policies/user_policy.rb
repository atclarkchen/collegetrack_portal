class UserPolicy < ApplicationPolicy

  def edit?
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      end
    end
  end
end
