class UserPolicy < ApplicationPolicy
  # Must be a logged in admin to look at all users
  def index?
    user && user.admin?
  end
  
  # Must be a logged in user
  def show?
    user
  end
  
  # Only logged out users and admins can create users
  def create?
    !user || (user && user.admin?)
  end
  
  # The user has to either be updating their own record or they're an admin
  def update?
    user && (user == record || user.admin?)
  end
  
  # Must be a logged in user
  def friends?
    user
  end
  
  # The user must be adding friends for themselves or they're an admin
  def add_friend?
    user && (user == record || user.admin?)
  end
  
  # Same authorization as "add_friend?"
  def remove_friend?
    add_friend?
  end
  
  # The user has to either be deleting their own record or they're an admin
  def destroy?
    user && (user == record || user.admin?)
  end
  
  # Must be a logged in user
  def search?
    user
  end
  
  # Other policies
  
  # The user can only look at their own trips or they're an admin
  # This policy is in the user policy instead of the trips policy because
  # the record we're checking is the user that owns the trips.
  def trips_index?
    user && (user == record || user.admin?)
  end
  
  # The user can only look at their own redemptions or they're an admin
  def redemptions_index?
    trips_index?
  end
end
