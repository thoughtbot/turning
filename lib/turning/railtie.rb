require 'rails/railtie'
require 'turning/static_cascade'
require 'turning/file_storage'
require 'turning/configuration'

module Turning
  class Railtie < ::Rails::Railtie
    config.turning = Configuration.new

    initializer('turning.middleware') do
      config.app_middleware.use StaticCascade, config.turning.storage
    end
  end
end
