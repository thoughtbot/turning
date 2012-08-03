require 'spec_helper'
require 'turning/controller'

describe Turning::Controller do
  it 'sets up a listener' do
    listening = false
    concrete_controller = Class.new(Turning::Controller) do
      define_method :listen do
        listening = true
      end
    end

    concrete_controller.new(mock_renderer).listen

    listening.should be
  end

  it 'renders' do
    concrete_controller = Class.new(Turning::Controller) do
      def do_it
        render 'index', 'hello-index', greeting: 'hello'
      end
    end
    renderer = mock_renderer

    concrete_controller.new(renderer).do_it

    renderer.should have_rendered('index', 'hello-index', greeting: 'hello')
  end

  it 'renders without assigns' do
    concrete_controller = Class.new(Turning::Controller) do
      def do_it
        render 'index', 'index-unassigned'
      end
    end
    renderer = mock_renderer

    concrete_controller.new(renderer).do_it

    renderer.should have_rendered('index', 'index-unassigned', {})
  end

  def mock_renderer
    stub('mock renderer', render_to_file: nil)
  end

  def have_rendered(template_name, path, assigns)
    have_received(:render_to_file).with(template_name, path, assigns)
  end
end
