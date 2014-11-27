class PagesController < ApplicationController
  def home
    if params[:lat].present?
      @lat = params[:lat]
      @lng = params[:lng]
    else
      @lat = 29.76
      @lng = -95.38
    end
    @venues = []
  end

  def visit
    results = Geocoder.search(params[:city]["city"])
    @lat = results.first.data["lat"].to_f.round(2)
    @lng = results.first.data["lon"].to_f.round(2)
    redirect_to root_path({lat: @lat, lng: @lng})
  end
end
