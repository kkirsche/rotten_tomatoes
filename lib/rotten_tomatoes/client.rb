require 'hurley'
require 'json'

module RottenTomatoes
  # The Client class is the interface to the Rotten Tomatoes API
  class Client
    attr_accessor :client
    def initialize(api_key)
      @api_key = api_key
      @client = Hurley::Client.new 'http://api.rottentomatoes.com/api/public/v1.0'
    end

    def api_key
      @api_key
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

    def upcoming_movies(args = {})
      response = @client.get('lists/movies/upcoming.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def top_rentals(args = {})
      response = @client.get('lists/dvds/top_rentals.json',
                             argument_hash(args, [:limit, :country]))
      JSON.parse(response.body)
    end

    def current_dvd_releases(args = {})
      response = @client.get('lists/dvds/current_releases.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def new_dvd_releases(args = {})
      response = @client.get('lists/dvds/new_releases.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def upcoming_dvds(args = {})
      response = @client.get('lists/dvds/upcoming.json',
                             argument_hash(args,
                                           [:page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def movie_info(movie_id, args = {})
      response = @client.get("movies/#{movie_id}.json", argument_hash(args))
      JSON.parse(response.body)
    end

    def movie_cast(movie_id, args = {})
      response = @client.get("movies/#{movie_id}/cast.json", argument_hash(args))
      JSON.parse(response.body)
    end

    def movie_reviews(movie_id, args = {})
      response = @client.get("movies/#{movie_id}/reviews.json",
                             argument_hash(args, [:review_type, :page_limit, :page, :country]))
      JSON.parse(response.body)
    end

    def similar_movies(movie_id, args = {})
      response = @client.get("movies/#{movie_id}/similar.json",
                             argument_hash(args, [:limit]))
      JSON.parse(response.body)
    end

    def movie_alias(args = {})
      response = @client.get('movie_alias.json',
                             argument_hash(args, [:type, :id]))
      JSON.parse(response.body)
    end
  end
end
