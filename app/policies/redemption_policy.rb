class RedemptionPolicy < ApplicationPolicy
  # The user can only see their own redemptions or they're an admin
  def show?
    user && (user == record.user || user.admin?)
  end
  
  # Same as "show?"
  def create?
    show?
  end
  
  # Only an admin can update a redemption
  def update?
    user && user.admin?
  end
  
  # Only an admin can destroy a redemption
  def destroy?
    update?
  end
end
