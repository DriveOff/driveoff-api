class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  def index
    @rewards = Reward.all.includes(:business).page(params[:page])
  end

  def show
  end

  def create
    @reward = Reward.new(reward_params)

    if @reward.save
      render :show, status: :created, location: @reward
    else
      render json: @reward.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reward.update(reward_params)
      render :show, status: :ok, location: @reward
    else
      render json: @reward.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @reward.destroy
    head :no_content
  end

  private
    def set_reward
      @reward = Reward.find_by_id(params[:id]) || raise_404
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      params.fetch(:reward, {}).permit(:title, :description, :cost, :business_id)
    end
end
