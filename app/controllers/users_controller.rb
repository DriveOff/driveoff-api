class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
  end
  
  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      
      render :show, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    head :no_content
  end

  private
  
    def set_user
      @user = User.find_by_id(params[:id]) || raise_404
    end


    def user_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :name, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns)
    end
end
