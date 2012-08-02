module Turning
  class Renderer
    def initialize(controller_path)
      @controller_path = controller_path
      @renderable = Class.new(AbstractController::Base) {
        include AbstractController::Rendering
        include AbstractController::Layouts
        include ActionController::Helpers
        include Rails.application.routes.url_helpers
        attr_accessor :view_assigns

        # Search for views based on the controller name
        attr_accessor :controller_path
        self.view_paths = 'app/views'

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
      }.new
      @renderable.controller_path = @controller_path
    end

    def render_to_file(template_name, assigns)
      @renderable.view_assigns = assigns
      target = target_path.join("#{template_name}.html")
      contents = @renderable.render_to_string(action: template_name)
      FileUtils.mkdir_p(target_path)
      File.open(target, 'w') { |file| file.write(contents) }
    end

    private

    def target_path
      Rails.root.join('public', 'cached', @controller_path)
    end
  end
end
