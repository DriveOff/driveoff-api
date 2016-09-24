class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.all
    render json: @users, only: [:id, :email, :name, :created_at, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns]
  end
  
  def show
    render json: @user, only: [:id, :email, :name, :created_at, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns]
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        auto_login(@user)
        
        format.html { redirect_to :root, notice: 'Thanks for signing up.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to edit_user_path(@user), notice: 'Your account was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_user
      @user = User.find_by_id(params[:id])
    end


    def user_params
      params.fetch(:user, {}).permit(:email, :password, :password_confirmation, :name, :role, :avatar, :city, :state, :zip_code, :gender, :custom_gender, :pronouns)
    end
end
