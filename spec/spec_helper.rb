# frozen_string_literal: true

require 'dotenv/load'
require 'rspec'
require 'faker'
require 'factory_bot'
require 'faraday'
require 'vcr'
require 'webmock/rspec'
require_relative '../lib/pix_charge'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  VCR.configure do |config|
    config.cassette_library_dir = 'spec/vcr_cassettes'
    config.hook_into :webmock
    config.configure_rspec_metadata!
    config.filter_sensitive_data('<API_KEY>') { ENV['API_KEY'] }
    config.filter_sensitive_data('<API_HOST>') { ENV['API_HOST'] }
  end
  

  config.include FactoryBot::Syntax::Methods

  FactoryBot.definition_file_paths = %w[spec/factories]
  FactoryBot.find_definitions
end

Faker::Config.locale = 'pt-BR'
