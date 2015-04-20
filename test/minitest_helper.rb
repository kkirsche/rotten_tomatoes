require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rotten_tomatoes'
require 'hurley/test'
require 'minitest/autorun'

# RottenTomatoesTest houses all tests for the
# RottenTomatoes API Library
module RottenTomatoesTest
end
