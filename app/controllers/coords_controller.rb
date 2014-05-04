require 'open-uri'
require 'json'

class CoordsController < ApplicationController
  def fetch_weather

   if params[:location].nil?
      @location = "Northwestern University"
    else
      @location = params["location"]
    end

    @url_safe_location = URI.encode(@location)

    location_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@url_safe_location}&sensor=true"
    raw_data = open(location_url).read
    parsed_data = JSON.parse(raw_data)
    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    api_key = "0832bbed96c0963fa272685eab1057a5"

    weather_url = "https://api.forecast.io/forecast/#{api_key}/#{@latitude},#{@longitude}"
    raw_data = open(weather_url).read
    parsed_data = JSON.parse(raw_data)
    @temperature = parsed_data["currently"]["temperature"]
    @minutely_summary = parsed_data["minutely"]["summary"]
    @hourly_summary = parsed_data["hourly"]["summary"]
    @daily_summary = parsed_data["daily"]["summary"]
  end
end
