require 'hurley'
require 'json'

module RottenTomatoes
  # The Client class is the interface to the Rotten Tomatoes API
  class Client
    attr_accessor :client
    attr_reader :api_key
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

    def request(args = {})
      response = @client.get(args[:url],
                             argument_hash(args[:args] || {},
                                           args[:symbols] || []))
      JSON.parse(response.body)
    end

    def movies_search(args = {})
      request url: 'movies.json', args: args, symbols: [:q, :page_limit, :page]
    end

    def lists_directory
      request url: 'lists.json'
    end

    def movie_lists_directory
      request url: 'lists/movies.json'
    end

    def dvd_lists_directory
      request url: 'lists/dvds.json'
    end

    def box_office_movies(args = {})
      request url: 'lists/movies/box_office.json',
              args: args, symbols: [:limit, :country]
    end

    def in_theater_movies(args = {})
      request url: 'lists/movies/in_theaters.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    def opening_movies(args = {})
      request url: 'lists/movies/opening.json',
              args: args, symbols: [:limit, :country]
    end

    def upcoming_movies(args = {})
      request url: 'lists/movies/upcoming.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    def top_rentals(args = {})
      request url: 'lists/dvds/top_rentals.json',
              args: args, symbols: [:limit, :country]
    end

    def current_dvd_releases(args = {})
      request url: 'lists/dvds/current_releases.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    def new_dvd_releases(args = {})
      request url: 'lists/dvds/new_releases.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    def upcoming_dvds(args = {})
      request url: 'lists/dvds/upcoming.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    def movie_info(movie_id, args = {})
      request url: "movies/#{movie_id}.json", args: args
    end

    def movie_cast(movie_id, args = {})
      request url: "movies/#{movie_id}/cast.json", args: args
    end

    def movie_reviews(movie_id, args = {})
      request url: "movies/#{movie_id}/reviews.json",
              args: args, symbols: [:review_type, :page_limit, :page, :country]
    end

    def similar_movies(movie_id, args = {})
      request url: "movies/#{movie_id}/similar.json",
              args: args, symbols: [:limit]
    end

    def movie_alias(args = {})
      request url: 'movie_alias.json', args: args, symbols: [:type, :id]
    end
  end
end
