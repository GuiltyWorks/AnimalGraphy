require "geocoder"
require "net/https"
require "uri"
require "json"

class ZooController < ApplicationController
  def index
    coordinates = Geocoder.search(request.remote_ip).first.coordinates

    api_key = "API_KEY"
    lat = coordinates[0]
    lng = coordinates[1]
    rad = "50000"
    types = "zoo"
    language = "ja"
    @zoos = []

    uri = URI.parse("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{rad}&types=#{types}&sensor=false&language=#{language}&key=#{api_key}")
    request = Net::HTTP::Get.new(uri.request_uri)
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
      http.request(request)
    end
    body = JSON.parse(response.body)
    results = body["results"]

    results.each_with_index do |place, idx|
      width, height, photo_reference, image_uri = "", "", "", ""
      if place["photos"]
        width = place["photos"][0]["width"]
        height = place['photos'][0]['height']
        photo_reference = place['photos'][0]['photo_reference']
        image_uri = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=#{width}&maxheight=#{height}&photoreference=#{photo_reference}&key=#{api_key}"
      end
      @zoos.push({
        image: image_uri,
        name: place["name"],
        uri: "https://www.google.co.jp/maps/search/#{place['geometry']['location']['lat']},#{place['geometry']['location']['lng']}"
      })
    end
  end
end
