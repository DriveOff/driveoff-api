class BusinessesController < ApplicationController
  before_action :set_business, only: [:show, :edit, :update, :destroy]

  def index
    @businesses = Business.all.page(params[:page])
  end

  def show
  end

  def create
    @business = Business.new(business_params)

    if @business.save
      render :show, status: :created, location: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  def update
    if @business.update(business_params)
      render :show, status: :ok, location: @business
    else
      render json: @business.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @business.destroy
    head :no_content
  end

  private
    def set_business
      @business = Business.find_by_id(params[:id]) || raise_404
    end

    def business_params
      params.fetch(:business, {}).permit(:name, :user_id)
    end
end
