class UserPolicy < ApplicationPolicy
  # Must be a logged in admin to look at all users
  def index?
    user && user.admin?
  end
  
  # Must be a logged in user
  def show?
    user
  end
  
  # Anyone can create a user
  def create?
    true
  end
  
  # The user has to either be updating their own record or they're an admin
  def update?
    user && (user == record || user.admin?)
  end
  
  # The user has to either be looking at their own friends or they're an admin
  def friends?
    user && (user == record || user.admin?)
  end
  
  # Same authorization as "friends?"
  def add_friend?
    friends?
  end
  
  # Same authorization as "friends?"
  def remove_friend?
    friends?
  end
  
  # The user has to either be updating their own record or they're an admin
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
end
