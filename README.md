[![Build Status](https://travis-ci.org/kkirsche/rotten_tomatoes.svg?branch=master)](https://travis-ci.org/kkirsche/rotten_tomatoes) [![Test Coverage](https://codeclimate.com/github/kkirsche/rotten_tomatoes/badges/coverage.svg)](https://codeclimate.com/github/kkirsche/rotten_tomatoes) [![Code Climate](https://codeclimate.com/github/kkirsche/rotten_tomatoes/badges/gpa.svg)](https://codeclimate.com/github/kkirsche/rotten_tomatoes) [![Gem Version](https://badge.fury.io/rb/rotten_tomatoes.svg)](http://badge.fury.io/rb/rotten_tomatoes) [![Dependency Status](https://gemnasium.com/kkirsche/rotten_tomatoes.svg)](https://gemnasium.com/kkirsche/rotten_tomatoes)

# Rotten Tomatoes

Welcome to the Rotten Tomatoes Gem, your unofficial wrapper for the complete Rotten Tomatoes v1.0 JSON API. Here, I work to provide developers with a full featured library letting them focus on the important part, their idea.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rotten_tomatoes'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rotten_tomatoes

## Usage

    $ gem install rotten_tomatoes

    # your_file.rb
    require 'rotten_tomatoes'
    api_client = RottenTomatoes::Client.new api_key: 'myAPIkey'
    # Start enjoying the Rotten Tomatoes API

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/kkirsche/rotten_tomatoes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
