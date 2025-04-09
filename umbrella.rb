# Write your solution below!

require "http"
require "json"
require "dotenv/load"

pp gmap_apikey = ENV.fetch("gmaps_key")
pp pirweather_apikey = ENV.fetch("pirweather_key")

#asking for location 
pp "Hi! Where are you located?"

#And storing it in location variable
location = gets.chomp 

#Get long and latitude from google maps API

gmap_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + location.gsub(" ", "%20") + "&key=" + gmap_apikey

gmap_response = HTTP.get(gmap_url)

gmap_raw_body = gmap_response.to_s

gmap_parsed = JSON.parse(gmap_raw_body)

gmap_hash = gmap_parsed.fetch("results")

address = gmap_hash.at(0)

geometry = address.fetch("geometry")

location = geometry.fetch("location")

lat = location.fetch("lat")
lng = location.fetch("lng")

#Get the weather at the user’s coordinates from the Pirate Weather API.

pirweather_url = "https://api.pirateweather.net/forecast/" + pirweather_apikey + "/" + lat.to_s + "," + lng.to_s

pirweather_response = HTTP.get(pirweather_url)

pirweather_raw_body = pirweather_response.to_s

pirweather_parsed = JSON.parse(pirweather_raw_body)

#Display the current temperature and summary of the weather for the next hour.

temp = pirweather_parsed.fetch("currently")

pp temp.fetch("temperature")
