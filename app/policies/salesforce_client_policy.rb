class SalesforceClientPolicy < ApplicationPolicy
  
  def permitted_attributes
  	if user.admin?
  		[:password, :security_token]
  	end
  end

  def reset?
  	user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
      	scope.all?
      end
    end
  end
end
