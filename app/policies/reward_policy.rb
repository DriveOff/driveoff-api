class RewardPolicy < ApplicationPolicy
  # Only logged in users can view the rewards index
  def index?
    user
  end
  
  # Same as "index?"
  def show?
    user
  end
  
  # Only admins and business admins can create rewards
  def create?
    user && (user.admin? || user.business_admin?)
  end
  
  # Only admins and business admins that own the reward can update rewards
  def update?
    user && (user.admin? || record.user == user)
  end
  
  # Same as "update?"
  def destroy?
    update?
  end
end
