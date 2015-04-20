require 'hurley'
require 'json'

module RottenTomatoes
  # The Client class is the interface to the Rotten Tomatoes API
  class Client
    def initialize(api_key)
      @api_key = api_key
      @client = Hurley::Client.new 'http://api.rottentomatoes.com/api/public/v1.0'
    end

    def argument_hash(args = {}, symbols = [])
      {}.tap do |hash|
        hash[:apikey] = @api_key
        symbols.map do |sym|
          hash[sym] = args[sym] unless args[sym].nil?
        end
      end
    end

    def movies_search(args = {})
      response = @client.get('movies.json',
                             argument_hash(args, [:q, :page_limit, :page]))

      JSON.parse(response.body)
    end

    def lists_directory
      response = @client.get('lists.json', argument_hash)
      JSON.parse(response.body)
    end

    def movie_lists_directory
      response = @client.get('lists/movies.json', argument_hash)
      JSON.parse(response.body)
    end

    def dvd_lists_directory
      response = @client.get('lists/dvds.json', argument_hash)
      JSON.parse(response.body)
    end

    def box_office_movies(args = {})
      response = @client.get('lists/movies/box_office.json',
                             argument_hash(args, [:limit, :country]))
      JSON.parse(response.body)
    end

    def in_theater_movies(args = {})
      response = @client.get('lists/movies/in_theaters.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def opening_movies(args = {})
      response = @client.get('lists/movies/opening.json',
                             argument_hash(args, [:limit, :country]))
      JSON.parse(response.body)
    end

    def upcoming_movies(args = {})
      response = @client.get('lists/movies/upcoming.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end
  end
end
