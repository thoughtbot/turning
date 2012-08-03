require 'rails/railtie'
require 'turning/static_cascade'
require 'turning/file_storage'

module Turning
  class Railtie < ::Rails::Railtie
    initializer('turning.middleware') do
      config.app_middleware.use StaticCascade,
        FileStorage.new(Rails.root.join('public', 'static'))
    end
  end
end
