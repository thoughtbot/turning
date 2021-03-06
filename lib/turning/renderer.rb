require 'action_view'
require 'active_support/core_ext/module/attr_internal'
require 'active_support/log_subscriber'
require 'abstract_controller/view_paths'
require 'abstract_controller/rendering'
require 'abstract_controller/layouts'
require 'abstract_controller/helpers'
require 'action_controller/metal/helpers'

module Turning
  class Renderer
    def initialize(controller_path, storage)
      @controller_path = controller_path
      @storage = storage
      @renderable = Class.new(AbstractController::Base) {
        include AbstractController::Rendering
        include AbstractController::Layouts
        include ActionController::Helpers
        include Rails.application.routes.url_helpers
        attr_accessor :view_assigns

        # Search for views based on the controller name
        attr_accessor :controller_path
        self.view_paths = ActionController::Base.view_paths

        # Include all helpers from the application's helper paths
        def self.helpers_path
          Rails.application.helpers_paths
        end
        helper :all

        # We can't protect against forgery in static HTML, because it requires a session
        def protect_against_forgery?
          false
        end
        helper_method :protect_against_forgery?

        # Look for a "static" layout by default, but don't fail if it doesn't exist
        def self.name
          'StaticController'
        end
        layout nil

        # So that controller.action_name continues to work
        attr_accessor :action_name
      }.new
      @renderable.controller_path = @controller_path
    end

    def render_to_file(template_name, path, assigns)
      @renderable.view_assigns = assigns
      @renderable.action_name = template_name
      contents = @renderable.render_to_string(action: template_name)
      @storage.put(path, contents)
    end
  end
end
