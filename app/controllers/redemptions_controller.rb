class RedemptionsController < ApplicationController
  before_action :set_redemption, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @redemptions = @user.redemptions.page(params[:page])
  end

  def show
  end

  def create
    @redemption = Redemption.new(redemption_params)

    if @redemption.save
      render :show, status: :created, location: @redemption
    else
      render json: @redemption.errors, status: :unprocessable_entity
    end
  end
  
  def update
    if @redemption.update(redemption_params)
      render :show, status: :ok, location: @redemption
    else
      render json: @redemption.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @redemption.destroy
    head :no_content
  end

  private
  
    def set_redemption
      @redemption = Redemption.find_by_id(params[:id]) || raise_404
    end
  
    def set_user
      @user = User.find_by_id(params[:user_id]) || raise_404
    end

    def redemption_params
      params.fetch(:redemption, {})
    end
end
