class RedemptionsController < ApplicationController
  before_action :set_and_authorize_redemption, only: [:show, :edit, :destroy]
  before_action :set_user

  def index
    authorize @user, :redemptions_index?
    @redemptions = @user.redemptions.page(params[:page])
  end

  def show
  end

  def create
    @redemption = Redemption.new(redemption_params)
    authorize @redemption

    if @redemption.save
      render :show, status: :created
    else
      render json: { errors: @redemption.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def destroy
    @redemption.destroy
    head :no_content
  end

  private
  
    def set_and_authorize_redemption
      @redemption = Redemption.find_by_id(params[:id]) || raise_404
      authorize @redemption
    end
  
    def set_user
      @user = User.find_by_id(params[:user_id]) || raise_404
    end

    def redemption_params
      params.slice(:reward_id).permit!
    end
end
