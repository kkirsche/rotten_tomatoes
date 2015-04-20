require 'hurley'
require 'json'

module RottenTomatoes
  # The Client class is the interface to the Rotten Tomatoes API
  class Client
    def initialize(api_key)
      @api_key = api_key
      @client = Hurley::Client.new 'http://api.rottentomatoes.com/api/public/v1.0'
    end

    def movies_search(args = {})
      response = @client.get('movies.json', {}.tap do |hash|
        hash[:apikey] = @api_key
        [:q, :page_limit, :page].map do |sym|
          hash[sym] = args[sym] unless args[sym].nil?
        end
      end)

      JSON.parse(response.body)
    end

    def lists_directory
      response = @client.get('lists.json', apikey: @api_key)
      JSON.parse(response.body)
    end

    def movie_lists_directory
      response = @client.get('lists/movies.json', apikey: @api_key)
      JSON.parse(response.body)
    end

    def box_office_movies(args = {})
      response = @client.get('lists/movies/box_office.json', {}.tap do |hash|
        hash[:apikey] = @api_key
        [:limit, :country].map do |sym|
          hash[sym] = args[sym] unless args[sym].nil?
        end
      end)
      JSON.parse(response.body)
    end
  end
end
