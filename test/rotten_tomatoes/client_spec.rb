require 'minitest_helper'

module RottenTomatoesTest
  # Test the Rotten Tomatoes API Library
  class Client
    describe 'Rotten Tomatoes API Library',
             'The client used to interact with the Rotten Tomatoes API' do
      it 'should initialize and set defaults without error' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        assert_kind_of RottenTomatoes::Client, client
        expect(client.api_key).must_equal 'myAPIkey'
        client.wont_be_nil
      end

      it 'should search for movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movies.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movies_search(
            q: 'test', page_limit: 30, page: 1
          )
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should list directories' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.lists_directory
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should list movie directories' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/movies.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movie_lists_directory
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should list dvd directories' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/dvds.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.dvd_lists_directory
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve box office movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/movies/box_office.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.box_office_movies limit: 10, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve in theater movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/movies/in_theaters.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.in_theater_movies page_limit: 16, page: 1, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve opening movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/movies/opening.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.opening_movies limit: 16, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve upcoming movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/movies/upcoming.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.upcoming_movies page_limit: 16, page: 1, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve top rented movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/dvds/top_rentals.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.top_rentals limit: 16, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve currently released on disc movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/dvds/current_releases.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.current_dvd_releases page_limit: 16, page: 1, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve newly released on disc movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/dvds/new_releases.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.new_dvd_releases page_limit: 16, page: 1, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve upcoming on disc movies' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/lists/dvds/upcoming.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.upcoming_dvds page_limit: 16, page: 1, country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve a movie\'s information' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movies/770672122.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movie_info '770672122'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve a movie\'s cast' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movies/770672122/cast.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movie_cast '770672122'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve a movie\'s reviews' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movies/770672122/reviews.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movie_reviews '770672122',
                               review_type: 'top_critic',
                               page_limit: 20,
                               page: 1,
                               country: 'us'
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve a movies which are similar to a movie' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movies/770672122/similar.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.similar_movies '770672122', limit: 5
        ).must_equal JSON.parse(%({"id": 1}))
      end

      it 'should retrieve a movie\'s aliases' do
        client = RottenTomatoes::Client.new 'myAPIkey'

        client.client.connection = Hurley::Test.new do |test|
          test.get '/api/public/v1.0/movie_alias.json' do
            [200, { 'Content-Type' => 'application/json' }, %({"id": 1})]
          end
        end

        expect(
          client.movie_alias type: 'imdb', id: '1'
        ).must_equal JSON.parse(%({"id": 1}))
      end
    end
  end
end
