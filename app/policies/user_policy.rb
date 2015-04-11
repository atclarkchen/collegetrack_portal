class UserPolicy < ApplicationPolicy

  def edit_users?
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
