class TripPolicy < ApplicationPolicy
  def index?
  end

  def show?
    user && user.trips.include?(record)
  end
  
  def create?
  end

  def update?
  end

  def destroy?
  end
end
