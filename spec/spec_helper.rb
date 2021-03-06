require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RACK_ENV"] ||= "test"
require 'capybara/rspec'
require './app/models/peep'
require './app/models/user'
require './app/app'
require 'database_cleaner'
require 'web_helper'
require 'timecop'
require_relative 'helpers/session'

Capybara.app = Chitter_Challenge

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

RSpec.configure do |config|
  config.include SessionHelpers
end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

    RSpec.configure do |config|
    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

  end

end
