module Turning
  class Controller
    def initialize(renderer)
      @renderer = renderer
    end

    private

    def render(template_name, assigns = {})
      @renderer.render_to_file(template_name, assigns)
    end
  end
end
