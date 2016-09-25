class ApplicationController < ActionController::Base
  include Pundit
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  def raise_404
    raise ActionController::RoutingError.new("Not found")
  end
  
  def user_not_authorized(exception)
    raise ActionController::RoutingError.new("Forbidden")
  end
end
