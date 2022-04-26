require 'benchmark'



# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# date = Date.new(2020,1,11)
# # p date
# # p date.tomorrow
# puts Benchmark.measure {

# new_games = []
# 12.times do
#   # sleep 2

#   p "day"
#   p date.day
#   p "month"
#   p date.month
#   response = HTTP.get("https://api.sportradar.us/ncaamb-t3/games/2020/#{date.month}/#{date.day}/schedule.json?api_key=")



#   p "response"
#   p response

#   object = response.parse

#   @games = object['games']

#   # first_five = @games.first(5)

#   @games.each_with_index do |game, index|
#     p index
#     p game
#     if game
#       new_games << Game.create(
#         scheduled: game['scheduled'],
#         venue: game['venue']['name'],
#         capacity: game['venue']['capacity'],
#         address: game['venue']['address'],
#         city: game['venue']['city'],
#         state: game['venue']['state'],
#         zip: game['venue']['zip'],
#         home: game['home']['name'],
#         away: game['away']['name']
#       )
#     end
#   end
#   date = date.tomorrow
# end
# }
puts Benchmark.measure {

games = Game.where('id > 2180').order(:id)


games.each do |game|
  # sleep 1

  if game.address && game.city && game.state && game.zip
    address = game.address + " " + game.city + " " + game.state + " " + game.zip
    p game.id
    p address
    # binding.pry
    # coordinates = Geocoder.coordinates(address)


    formatted_address = game.address.split(" ").join("+")
    formatted_city = game.city.split(" ").join("+")


    url = "http://www.mapquestapi.com/geocoding/v1/address?key=&street=#{formatted_address}&city=#{formatted_city}&state=#{game.state}&postalCode=#{game.zip}"
    response = HTTP.get(url)
    # binding.pry
    info = response.parse
    latitude = info['results'][0]['locations'][0]['latLng']['lat']
    longitude = info['results'][0]['locations'][0]['latLng']['lng']
    if latitude && longitude
      game.update!(
        lat: latitude,
        lon: longitude
      )
    else
      p "didn't work"
    end
  else
    p "bad address"
  end
end

# MOST OF THE LOCATIONS ARE WRONG. DO THEM ALL OVER AGAIN

# games = Game.where(lat: nil)

games.each do |game|
  game.scheduled = game.scheduled - 6.hours
  game.save
end
}


# 2180 highest id
