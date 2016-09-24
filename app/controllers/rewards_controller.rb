class RewardsController < ApplicationController
  before_action :set_reward, only: [:show, :edit, :update, :destroy]

  def index
    @rewards = Reward.all
    render json: @rewards
  end

  def show
    render json: @reward
  end

  def create
    @reward = Reward.new(reward_params)

    respond_to do |format|
      if @reward.save
        format.html { redirect_to @reward, notice: 'Reward was successfully created.' }
        format.json { render :show, status: :created, location: @reward }
      else
        format.html { render :new }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reward.update(reward_params)
        format.html { redirect_to @reward, notice: 'Reward was successfully updated.' }
        format.json { render :show, status: :ok, location: @reward }
      else
        format.html { render :edit }
        format.json { render json: @reward.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reward.destroy
    respond_to do |format|
      format.html { redirect_to rewards_url, notice: 'Reward was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_reward
      @reward = Reward.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reward_params
      params.fetch(:reward, {}).permit(:title, :description, :cost, :business_id)
    end
end
