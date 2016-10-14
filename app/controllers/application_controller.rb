class ApplicationController < ActionController::Base
  include Pundit
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_filter :authenticate_user
  
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  
  def authenticate_user
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)
    # byebug
    
    user_email = options.blank? ? nil : options[:email]
    user = user_email && User.find_by_email(user_email)
    
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      user.extend_authentication_token_expiration
      @current_user = user
    else
      @current_user = nil
    end
  end
  
  def pundit_user
    @current_user
  end
  
  def raise_404
    raise ActionController::RoutingError.new("Not found")
  end
  
  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    
    self.status = :unauthorized
    render json: {
      error: 'Unauthorized',
      status: 401,
      message: t("#{policy_name}.#{exception.query}", scope: "pundit", default: :default)
    }
    return
  end
end
