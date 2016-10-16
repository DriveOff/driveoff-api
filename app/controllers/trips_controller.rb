class TripsController < ApplicationController
  before_action :set_and_authorize_trip, only: [:show, :update, :destroy]
  before_action :set_user

  def index
    authorize @user, :trips_index?
    @trips = @user.trips.page(params[:page])
  end

  def show
  end

  def create
    @trip = Trip.new(trip_params)
    authorize @trip

    if @trip.save
      render :show, status: :created, location: @trip
    else
      render json: { errors: @trip.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def update
    if @trip.update(trip_params)
      render :show, status: :ok, location: @trip
    else
      render json: { errors: @trip.errors.full_messages, status: :unprocessable_entity }
    end
  end

  def destroy
    @trip.destroy
    head :no_content
  end

  private
  
    def set_and_authorize_trip
      @trip = Trip.find_by_id(params[:id]) || raise_404
      authorize @trip
    end
    
    def set_user
      @user = User.find_by_id(params[:user_id]) || raise_404
    end

    def trip_params
      params.fetch(:trip, {}).permit(:distance, :time, :user_id)
    end
end
