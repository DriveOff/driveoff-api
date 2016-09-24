class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]
  before_action :set_user

  def index
    @trips = @user.trips
    render json: @trips
  end

  def show
    render json: @trip
  end

  def create
    @trip = Trip.new(trip_params)

    respond_to do |format|
      if @trip.save
        format.html { redirect_to @trip, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @trip.update(trip_params)
        format.html { redirect_to @trip, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    def set_trip
      @trip = Trip.find_by_id(params[:id])
    end
    
    def set_user
      @user = User.find_by_id(params[:user_id])
    end

    def trip_params
      params.fetch(:trip, {}).permit(:start_lat, :start_lng, :end_lat, :end_lng, :distance, :time, :points, :user_id)
    end
end
