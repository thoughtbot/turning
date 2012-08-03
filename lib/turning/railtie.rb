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

    initializer('turning.url_helpers') do
      Turning::Listener.class_eval do
        include Rails.application.routes.url_helpers
      end
    end
  end
end
