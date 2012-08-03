module Turning
  class Controller
    def initialize(renderer = nil)
      @renderer = renderer || default_renderer
    end

    private

    def render(template_name, assigns = {})
      @renderer.render_to_file(template_name, assigns)
    end

    def default_renderer
      Renderer.new(view_path, storage)
    end

    def view_path
      self.class.name.underscore.sub(/_controller$/, '')
    end

    def storage
      FileStorage.new(Rails.root.join('public', 'static'))
    end
  end
end
