require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================
    # downcase_street_address = @street_address.downcase
    beg_url = "https://maps.googleapis.com/maps/api/geocode/json?address="
    end_url = @street_address.gsub(' ','+')
    url = beg_url.concat(end_url)
    parsed_data = JSON.parse(open(url).read)


    @latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

    @longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    beg_url_f = "https://api.darksky.net/forecast/368c2f773b461a35901f3df4ffb81ded/"
    lat_lng_arry= [@latitude,",",@longitude]
    end_url_f=lat_lng_arry.join
    url_f = beg_url_f.concat(end_url_f)
    parsed_data_forecast = JSON.parse(open(url_f).read)

    @current_temperature = parsed_data_forecast["currently"]["temperature"]

    @current_summary = parsed_data_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data_forecast["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
