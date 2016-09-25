class UserSessionsController < ApplicationController
  def create
    if @user = login(params[:email], params[:password], params[:remember])
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    head :no_content
  end
end