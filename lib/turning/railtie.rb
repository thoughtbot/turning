require 'rails/railtie'
require 'turning/static_cascade'
require 'turning/file_storage'
require 'turning/configuration'
require 'turning/listener_loader'

module Turning
  class Railtie < ::Rails::Railtie
    config.turning = Configuration.new

    config.to_prepare do
      ListenerLoader.load
    end

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
