require 'spec_helper'
require 'turning/listener'

describe Turning::Listener do
  it 'sets up a listener' do
    listening = false
    concrete_listener = Class.new(Turning::Listener) do
      define_method :listen do
        listening = true
      end
    end

    concrete_listener.new(mock_renderer).listen

    listening.should be
  end

  it 'renders' do
    concrete_listener = Class.new(Turning::Listener) do
      def do_it
        render 'index', 'hello-index', greeting: 'hello'
      end
    end
    renderer = mock_renderer

    concrete_listener.new(renderer).do_it

    renderer.should have_rendered('index', 'hello-index', greeting: 'hello')
  end

  it 'renders without assigns' do
    concrete_listener = Class.new(Turning::Listener) do
      def do_it
        render 'index', 'index-unassigned'
      end
    end
    renderer = mock_renderer

    concrete_listener.new(renderer).do_it

    renderer.should have_rendered('index', 'index-unassigned', {})
  end

  it 'provides url helpers' do
    concrete_listener = Class.new(Turning::Listener) do
      def do_it
        render 'index', root_path
      end
    end
    renderer = mock_renderer

    concrete_listener.new(renderer).do_it

    renderer.should have_rendered('index', '/', {})
  end

  def mock_renderer
    stub('mock renderer', render_to_file: nil)
  end

  def have_rendered(template_name, path, assigns)
    have_received(:render_to_file).with(template_name, path, assigns)
  end
end
