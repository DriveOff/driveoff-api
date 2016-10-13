class UserSessionsController < ApplicationController
  def create
    if @user = login(params[:email], params[:password], params[:remember])
      represent_user_with_token(@user)
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    head :no_content
  end


  def represent_user_with_token(user)
    user.as_json(only: [:id, :email]).merge(token: ::TokenProvider.issue_token(
      user_id: user.id
    ))
  end
end