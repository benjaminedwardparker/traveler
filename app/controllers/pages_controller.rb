class PagesController < ApplicationController

  def home
    if params[:lat].present?
      @lat = params[:lat]
      @lng = params[:lng]
      @placename = params[:city]
    elsif current_user
      @lat = current_user.lat
      @lng = current_user.lng
      @placename = current_user.home_city
    else
      @lat = 29.76
      @lng = -95.38
      @placename = "Houston"
    end
    remote = Songkickr::Remote.new(ENV["SONGKICK_API_KEY"])
    results = remote.events(location: "geo:#{@lat},#{@lng}")#, type: 'festival')
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
    redirect_to root_path({lat: @lat, lng: @lng, city: @city})
  end
end
