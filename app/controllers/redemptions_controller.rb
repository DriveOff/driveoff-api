class RedemptionsController < ApplicationController
  before_action :set_redemption, only: [:show, :edit, :update, :destroy]
  before_action :set_user

  def index
    @redemptions = @user.redemptions
    render json: @redemptions
  end

  def show
    render json: @redemption
  end

  def create
    @redemption = Redemption.new(redemption_params)

    respond_to do |format|
      if @redemption.save
        format.html { redirect_to @redemption, notice: 'Redemption was successfully created.' }
        format.json { render :show, status: :created, location: @redemption }
      else
        format.html { render :new }
        format.json { render json: @redemption.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @redemption.update(redemption_params)
        format.html { redirect_to @redemption, notice: 'Redemption was successfully updated.' }
        format.json { render :show, status: :ok, location: @redemption }
      else
        format.html { render :edit }
        format.json { render json: @redemption.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @redemption.destroy
    respond_to do |format|
      format.html { redirect_to redemptions_url, notice: 'Redemption was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_redemption
      @redemption = Redemption.find(params[:id])
    end
  
    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def redemption_params
      params.fetch(:redemption, {})
    end
end
