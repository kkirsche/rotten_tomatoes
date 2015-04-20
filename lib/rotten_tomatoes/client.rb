require 'hurley'
require 'json'

module RottenTomatoes
  # The Client class is the interface to the Rotten Tomatoes API
  class Client
    attr_accessor :client
    attr_reader :api_key

    # == Client
    # RottenTomatoes::Client class is used to interact with the v1.0 JSON API for Rotten Tomatoes.
    #
    # == Parameters
    #
    # +api_key+ - String
    #
    # == Returns
    #
    # +self+ - Object
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    def initialize(api_key)
      @api_key = api_key
      @client = Hurley::Client.new 'http://api.rottentomatoes.com/api/public/v1.0'
      self
    end

    # == Argument Hash (Private Method)
    # Internal method, not for use by third-party developers. The argument_hash method is used to generate the hash which will be URL encoded when making the next request with the Rotten Tomatoes API.
    #
    # == Parameters
    #
    # +args+ - Hash - The original hash which was sent to the calling method.
    # +symbols - Array - An array of symbols which you would like to send to the API.
    #
    # == Returns
    #
    # Void
    #
    # == Example
    #
    #    def method(args ={})
    #      client.get(url, argument_hash(args, [:query, :page]))
    #    end
    def argument_hash(args = {}, symbols = [])
      {}.tap do |hash|
        hash[:apikey] = @api_key
        symbols.map do |sym|
          hash[sym] = args[sym] unless args[sym].nil?
        end
      end
    end
    private :argument_hash

    # == Request (Private Method)
    # Internal method, not for use by third-party developers. The request method is used to send the get request to the API and then will return the parsed body as a hash.
    #
    # == Parameters
    #
    # +args+ - Hash - The hash may, as all parameters except :url are optional, contain :url containing the API endpoint which will be contacted, :args which represent the arguments of the calling method, and :symbols which are the symbols which may be sent with the request. Examples include :page, :limit, :query.
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    client.request url: 'movies.json', args: args, symbols: [:q, :page_limit, :page]
    def request(args = {})
      response = @client.get(args[:url],
                             argument_hash(args[:args] || {},
                                           args[:symbols] || []))
      JSON.parse(response.body)
    end
    private :request

    # == Movies Search
    # The movies_search method is used to do plain text searches allowing you to find your favorite movies.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movies_Search
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :q - The plain text search query to search for a movie. Default value is nil.
    #   * :page_limit - The amount of movie search results to show per page. Default value is 30.
    #   * :page - The selected page of movie search results. Default value is 1.
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.movies_search q: 'Fight Club', page_limit: 100, page: 1
    #    response2 = client.movies_search
    #    response3 = client.movies_search q: 'Along Came Polly'
    def movies_search(args = {})
      request url: 'movies.json', args: args, symbols: [:q, :page_limit, :page]
    end

    # == Lists Directory
    # The lists_directory method is used to retrieve the top level lists available in the API.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Lists_Directory
    #
    # == Parameters
    #
    # None
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash with the following example response:
    #
    # links: {
    #   movies: 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies.json',
    #   dvds: 'http://api.rottentomatoes.com/api/public/v1.0/lists/dvds.json'
    # }
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.lists_directory
    def lists_directory
      request url: 'lists.json'
    end

    # == Movie Lists Directory
    # The movie_lists_directory method is used to retrieve the movie lists available.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Lists_Directory
    #
    # == Parameters
    #
    # None
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.movie_lists_directory
    def movie_lists_directory
      request url: 'lists/movies.json'
    end

    # == DVD Lists Directory
    # The dvd_lists_directory method is used to retrieve the dvd lists available.
    # http://developer.rottentomatoes.com/docs/read/json/v10/DVD_Lists_Directory
    #
    # == Parameters
    #
    # None
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.dvd_lists_directory
    def dvd_lists_directory
      request url: 'lists/dvds.json'
    end

    # == Box Office Movies
    # Displays Top Box Office Earning Movies, Sorted by Most Recent Gross Ticket Sales
    # http://developer.rottentomatoes.com/docs/read/json/v10/Box_Office_Movies
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :limit - Limits the number of box office movies returned. Default value is 10.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.box_office_movies limit: 50, country: 'us'
    #    response2 = client.box_office_movies
    def box_office_movies(args = {})
      request url: 'lists/movies/box_office.json',
              args: args, symbols: [:limit, :country]
    end

    # == In Theater Movies
    # Retrieves movies currently in theaters.
    # http://developer.rottentomatoes.com/docs/read/json/v10/In_Theaters_Movies
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :page_limit - The amount of movies in theaters to show per page. Default value is 16.
    #   * :page - The selected page of in theaters movies. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.in_theater_movies page_limit: 20, page: 3, country: 'us'
    #    response2 = client.in_theater_movies
    def in_theater_movies(args = {})
      request url: 'lists/movies/in_theaters.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    # == Opening Movies
    # Retrieves movies current opening movies.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Opening_Movies
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :limit - Limits the number of opening movies returned. Default value is 16.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.opening_movies limit: 20, country: 'us'
    #    response2 = client.opening_movies
    def opening_movies(args = {})
      request url: 'lists/movies/opening.json',
              args: args, symbols: [:limit, :country]
    end

    # == Upcoming Movies
    # Retrieves movies current opening movies.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Upcoming_Movies
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :page_limit - The amount of upcoming movies to show per page. Default value is 16.
    #   * :page - The selected page of upcoming movies. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.upcoming_movies page_limit: 20, page: 1, country: 'us'
    #    response2 = client.upcoming_movies
    def upcoming_movies(args = {})
      request url: 'lists/movies/upcoming.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    # == Top Rentals
    # Retrieves the current top dvd rentals.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Top_Rentals
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :limit - Limits the number of top rentals returned. Default value is 10.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.top_rentals limit: 20, country: 'us'
    #    response2 = client.top_rentals
    def top_rentals(args = {})
      request url: 'lists/dvds/top_rentals.json',
              args: args, symbols: [:limit, :country]
    end

    # == Current Release DVDs
    # Retrieves current release dvds. Results are paginated if they go past the specified page limit.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Current_Release_DVDs
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :page_limit - The amount of new release dvds to show per page. Default value is 16.
    #   * :page - The selected page of current DVD releases. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.current_dvd_releases page_limit: 20, page: 3, country: 'us'
    #    response2 = client.current_dvd_releases
    def current_dvd_releases(args = {})
      request url: 'lists/dvds/current_releases.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    # == New Release DVDs
    # Retrieves new release dvds. Results are paginated if they go past the specified page limit.
    # http://developer.rottentomatoes.com/docs/read/json/v10/New_Release_DVDs
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :page_limit - The amount of new release dvds to show per page. Default value is 16.
    #   * :page - The selected page of new release DVDs. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.new_dvd_releases page_limit: 20, page: 3, country: 'us'
    #    response2 = client.new_dvd_releases
    def new_dvd_releases(args = {})
      request url: 'lists/dvds/new_releases.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    # == Upcoming DVDs
    # Retrieves upcoming dvds. Results are paginated if they go past the specified page limit.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Upcoming_DVDs
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :page_limit - The amount of new release dvds to show per page. Default value is 16.
    #   * :page - The selected page of new release DVDs. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response1 = client.upcoming_dvds page_limit: 20, page: 3, country: 'us'
    #    response2 = client.upcoming_dvds
    def upcoming_dvds(args = {})
      request url: 'lists/dvds/upcoming.json',
              args: args, symbols: [:page_limit, :page, :country]
    end

    # == Movie Info
    # Detailed information on a specific movie specified by ID. You can use the movies_search method or peruse the lists of movies/dvds to get the urls to movies.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Info
    #
    # == Parameters
    #
    # +movie_id+ - Int / String - Example: 770672122
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.movie_info 770672122
    def movie_info(movie_id, args = {})
      request url: "movies/#{movie_id}.json", args: args
    end

    # == Movie Cast
    # Pulls the complete movie cast for a movie.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Cast
    #
    # == Parameters
    #
    # +movie_id+ - Int / String - Example: 770672122
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.movie_cast 770672122
    def movie_cast(movie_id, args = {})
      request url: "movies/#{movie_id}/cast.json", args: args
    end

    # == Movie Reviews
    # Retrieves the reviews for a movie. Results are paginated if they go past the specified page limit.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Reviews
    #
    # == Parameters
    #
    # +movie_id+ - Int / String - Example: 770672122
    # +args+ - Hash - May contain the following keys:
    #   * :review_type - 3 different review types are possible: "all", "top_critic", and "dvd". "top_critic" shows all the Rotten Tomatoes designated top critics. "dvd" pulls the reviews given on the DVD of the movie. "all" as the name implies retrieves all reviews. Default value is "top_critic".
    #   * :page_limit - The number of reviews to show per page. Default value is 20.
    #   * :page - The selected page of reviews. Default value is 1.
    #   * :country - Provides localized data for the selected country (ISO 3166-1 alpha-2) if available. Otherwise, returns US data. Default value is 'us'
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.movie_reviews 770672122, { review_type: 'all', page_limit: 20, page: 1, country: 'us' }
    def movie_reviews(movie_id, args = {})
      request url: "movies/#{movie_id}/reviews.json",
              args: args, symbols: [:review_type, :page_limit, :page, :country]
    end

    # == Movie Similar
    # Shows similar movies for a movie.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Similar
    #
    # == Parameters
    #
    # +movie_id+ - Int / String - Example: 770672122
    # +args+ - Hash - May contain the following keys:
    #   * :limit - Limit the number of similar movies to show.
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.similar_movies 770672122, limit: 5
    def similar_movies(movie_id, args = {})
      request url: "movies/#{movie_id}/similar.json",
              args: args, symbols: [:limit]
    end

    # == Movie Alias
    # Provides a movie lookup by an ID from a different vendor. Only supports imdb lookup at this time. WARNING: This feature is Beta quality. Accuracy of the lookup is not promised. If you see inaccuracies, please report them in the Rotten Tomatoes forums.
    # http://developer.rottentomatoes.com/docs/read/json/v10/Movie_Alias
    #
    # == Parameters
    #
    # +args+ - Hash - May contain the following keys:
    #   * :type - alias type you want to look up - only imdb is supported at this time.
    #   * :id - The ID you want to look up
    #
    # == Returns
    #
    # Hash - Response body after being parsed from JSON will be returned as a Hash.
    #
    # == Example
    #
    #    client = RottenTomatoes::Client.new 'myAPIkey'
    #    response = client.movie_alias id: 770672122, type: 'imdb'
    def movie_alias(args = {})
      request url: 'movie_alias.json', args: args, symbols: [:type, :id]
    end
  end
end
