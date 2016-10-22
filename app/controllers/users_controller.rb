class UsersController < ApplicationController
  before_action :set_and_authorize_user, only: [:show, :update, :friends, :add_friend, :remove_friend, :destroy]
  
  def index
    authorize User
    @users = User.all.page(params[:page])
  end
  
  def show
  end

  def create
    authorize User
    @user = User.new(user_params)

    if @user.save
      auto_login(@user)
      
      render :show, status: :created
    else
      render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok
    else
      render json: { errors: @user.errors.full_messages, status: :unprocessable_entity }
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
    authorize User
    @users = User.search_by_email(params[:query]).page(params[:page])
  end

  private
  
    def set_and_authorize_user
      @user = User.find_by_id(params[:id]) || raise_404
      authorize @user
    end

    def user_params
      params.slice(:email, :password, :password_confirmation, :name, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns).permit!
    end
end
