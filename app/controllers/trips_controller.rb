class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
    redirect_to root_path({})
  end

  def edit
  end

  def create
    @trip = Trip.new(params.require(:trip).permit(:user_id, :blurb, :lat, :lng, :city, :start_date, :end_date))
    @trip.save
    redirect_to root_path(id: @trip.id)
  end

  def destroy
  end

  private
    def set_trip
      @trip = Trip.find(params[:id])
    end

    def trip_params
      params.require(:trip).permit(:user_id, :blurb, :lat, :lng, :city, :start_date, :end_date)
    end
end
