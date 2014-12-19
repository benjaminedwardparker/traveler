class PagesController < ApplicationController

  def home
    @points = Point.all
    @trips = Trip.all
    if params[:id].present?
      @saved_trip = Trip.find(params[:id])
      @lat = @saved_trip.lat
      @lng = @saved_trip.lng
      @placename = @saved_trip.city
      session[:saved_trip_id] = params[:id]
    else
      if params[:lat].present?
        @lat = params[:lat]
        @lng = params[:lng]
        @placename = params[:city]
        if current_user
          @this_trip = Trip.new(user_id: current_user.id,
                           lat: @lat,
                           lng: @lng,
                           city: @placename,
                           start_date: params[:start_date],
                           end_date: params[:end_date])
          @trip = Trip.new
        end
      elsif current_user
        @lat = current_user.lat
        @lng = current_user.lng
        @placename = current_user.home_city
      else
        @lat = 29.76
        @lng = -95.38
        @placename = "Houston"
      end
    end
    @placename.capitalize!
    if @placename = 'Houston'
      @lat = 29.7628
      @lng = -95.3831
    end
    remote = Songkickr::Remote.new(ENV["SONGKICK_API_KEY"])
    if params[:start_date].present?
      results = remote.events(location: "geo:#{@lat},#{@lng}",
                              min_date: params[:start_date],
                              max_date: params[:end_date])
      @start_date = params[:start_date]
    elsif @saved_trip
      results = remote.events(location: "geo:#{@lat},#{@lng}",
                              min_date: @saved_trip.start_date,
                              max_date: @saved_trip.end_date)
      @start_date = @saved_trip.start_date
    else
      results = remote.events(location: "geo:#{@lat},#{@lng}")
    end

    if @start_date
      @trip_time = Date.parse(@start_date).to_time.to_i
      if ((@trip_time - Time.now.to_i) > 604800)
        forecast = ForecastIO.forecast(@lat,@lng, options = {time: (@trip_time+43200),
                                                             exclude: 'hourly,daily'})
        @summary = forecast.currently.summary
        @temp = forecast.currently.temperature.round
        @feels_like = forecast.currently.apparentTemperature.round
        @plus_minus = forecast.currently.temperatureError.round
      end
    end

    @venues = []
    results.results.each do |result|
      if result.location.lat.present?
        @venues << result
      end
    end
  end

  def visit
    @city = params[:city]["city"]
    results = Geocoder.search(@city)
    @lat = results.first.data["lat"].to_f.round(2)
    @lng = results.first.data["lon"].to_f.round(2)
    redirect_to root_path({lat: @lat,
                           lng: @lng,
                           city: @city,
                           start_date: params[:city]["start_date"],
                           end_date: params[:city]["end_date"]})
  end

  def create
    @point = Point.new(params.require(:point).permit(:name, :description, :location))
    @point.user_id = current_user.id
    @point.save
    redirect_to root_path
  end

  def about

  end

end
