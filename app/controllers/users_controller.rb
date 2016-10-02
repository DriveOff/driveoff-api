class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :friends, :add_friend, :destroy]
  
  def index
    @users = User.all.page(params[:page])
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
  
  def friends
    @friends = @user.friends.page(params[:page])
  end
  
  def add_friend
    @user2 = User.find_by_id(params[:id2]) || raise_404
    @user.add_friend(@user2)
    render json: @user, status: :ok
  end
  
  def remove_friend
    @user2 = User.find_by_id(params[:id2]) || raise_404
    @user.remove_friend(@user2)
    render json: @user, status: :ok
  end

  def destroy
    @user.destroy
    head :no_content
  end
  
  def search
    @users = User.search_by_email(params[:query]).page(params[:page])
  end

  private
  
    def set_user
      @user = User.find_by_id(params[:id]) || raise_404
    end

    def user_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :name, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns)
    end
end
