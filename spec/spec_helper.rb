require 'rspec'
require 'turning'
require 'bourne'

require './spec/testapp/config/application'
Dir["spec/support/**/*.rb"].each { |f| require File.expand_path(f) }

RSpec.configure do |config|
  config.mock_with :mocha
end
