class BusinessPolicy < ApplicationPolicy
  # Only admins can view the businesses index
  def index?
    user && user.admin?
  end
  
  # Only admins and the business admin who owns the business can view
  # the business
  def show?
    user && (user.admin? || record.user == user)
  end
  
  # Only admins can create businesses
  def create?
    user && user.admin?
  end
  
  # Only admins and the business admin who owns the business can update
  # the business
  def update?
    show?
  end
  
  # Only admins can destroy businesses
  def destroy?
    create?
  end
end
