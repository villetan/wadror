class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, expires_in: 1.week) { fetch_places_in(city)}
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.map do | place |
      Place.new(place)
    end
  end


  def self.key
    #raise "APIKEY env variable not defined" if ENV['APIKEY'].nil?
    #ENV['APIKEY']
    "b9dcb3dafc943a8ee05d93ead317c24c"
  end
end