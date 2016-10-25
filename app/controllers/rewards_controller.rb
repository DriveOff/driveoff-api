class RewardsController < ApplicationController
  before_action :set_and_authorize_reward, only: [:show, :edit, :update, :destroy]

  def index
    authorize Reward
    @rewards = Reward.all.includes(:business).page(params[:page])
  end

  def show
  end

  def create
    @reward = Reward.new(reward_params)
    authorize @reward

    if @reward.save
      render :show, status: :created
    else
      render json: { errors: @reward.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    if @reward.update(reward_params)
      render :show, status: :ok
    else
      render json: { errors: @reward.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def destroy
    @reward.destroy
    head :no_content
  end

  private
    def set_reward
      @reward = Reward.find_by_id(params[:id]) || raise_404
      authorize @reward
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      params.slice(:title, :description, :cost, :business_id).permit!
    end
end
