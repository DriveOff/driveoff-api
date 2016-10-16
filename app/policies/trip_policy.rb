class TripPolicy < ApplicationPolicy
  # The user can only see their own trips or they're an admin
  def show?
    user && (user == record.user || user.admin?)
  end
  
  # The rest of these policys are the same as "show?"
  def create?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
