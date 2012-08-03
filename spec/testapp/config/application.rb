require 'rails'
require 'action_controller/railtie'

module TestApp
  APP_ROOT = File.expand_path('..', __FILE__).freeze

  class Application < Rails::Application
    config.encoding = "utf-8"
    # config.paths.add 'config/routes', with: "#{APP_ROOT}/config/routes.rb"
    # config.paths.add 'app/controllers', with: "#{APP_ROOT}/app/controllers"
    # config.paths.add 'app/helpers', with: "#{APP_ROOT}/app/helpers"
    # config.paths.add 'app/views', with: "#{APP_ROOT}/app/views"
    # config.paths.add 'log', with: 'tmp/log'
    config.cache_classes = true
    config.whiny_nils = true
    config.consider_all_requests_local = true
    config.action_controller.perform_caching = false
    config.action_dispatch.show_exceptions = false
    config.action_controller.allow_forgery_protection = false
    config.active_support.deprecation = :stderr
    config.secret_token = "DIESEL" * 5 # so diesel

    def require_environment!
      initialize!
    end
  end
end
