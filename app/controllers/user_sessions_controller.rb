class UserSessionsController < ApplicationController
  def create
    if @user = login(params[:email], params[:password], params[:remember])
      render 'users/show', status: :created
    else
      render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def destroy
    logout
    head :no_content
  end
end
