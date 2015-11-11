require 'capybara/rspec'
require './app/models/peep'
require './app/app'
require "codeclimate-test-reporter"

Capybara.app = Chitter_Challenge
CodeClimate::TestReporter.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

end
