require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    beg_url_f = "https://api.darksky.net/forecast/368c2f773b461a35901f3df4ffb81ded/"
    lat_lng_arry= [@lat,",",@lng]
    end_url_f=lat_lng_arry.join
    url_f = beg_url_f.concat(end_url_f)
    parsed_data_forecast = JSON.parse(open(url_f).read)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
