module Turning
  class Controller
    def initialize(renderer = nil)
      @renderer = renderer || default_renderer
    end

    private

    def render(template_name, path, assigns = {})
      @renderer.render_to_file(template_name, path, assigns)
    end

    def default_renderer
      Renderer.new(view_path, storage)
    end

    def view_path
      self.class.name.underscore.sub(/_controller$/, '')
    end

    def storage
      Rails.configuration.turning.storage
    end
  end
end
