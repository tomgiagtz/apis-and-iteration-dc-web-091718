require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  response_string = RestClient.get('http://www.swapi.co/api/people/')
  response_hash = JSON.parse(response_string)

  char_info = get_character_info(response_hash, character)
  char_films = char_info["films"]

  films_hash = char_films.map do |url|
    get_film_info(url)
  end
end

def print_movies(films_hash)
  titles = films_hash.map do |films|
    films["title"]
  end
  titles.each_with_index do |title, index|
    puts "#{index + 1}. #{title}"
  end
end

def show_character_movies(character)
  films_array = get_character_movies_from_api(character)
  print_movies(films_array)
end

def get_character_info(char_hash, character)
  new_hash = char_hash["results"]
  new_hash.find do |char|
    char["name"].downcase == character.downcase
  end
end

def get_film_info(url)
  response_string = RestClient.get(url)
  response_hash = JSON.parse(response_string)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
