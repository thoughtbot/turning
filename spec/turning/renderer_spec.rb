require 'spec_helper'
require 'turning/renderer'

describe Turning::Renderer do
  it 'renders to a file' do
    create_view('examples/say_hello.html.erb', '<%= @greeting %>')
    storage = mock_storage
    renderer = Turning::Renderer.new('examples', storage)
    renderer.render_to_file('say_hello', '/result', greeting: 'Hello')

    storage.should have_static_view('/result', 'Hello')
  end

  it 'supplies built-in helpers' do
    create_view('examples/go_home.html.erb', '<%= link_to "go home", root_path %>')
    storage = mock_storage
    renderer = Turning::Renderer.new('examples', storage)
    renderer.render_to_file('go_home', '/result', {})

    storage.should have_static_view('/result', %{<a href="/">go home</a>})
  end

  it 'supplies custom helpers' do
    create_file('app/helpers/greeting_helper.rb', <<-HELPER)
      module GreetingHelper
        def greet
          'Hello'
        end
      end
    HELPER
    create_view('examples/greet_hello.html.erb', '<%= greet %>')
    storage = mock_storage
    renderer = Turning::Renderer.new('examples', storage)
    renderer.render_to_file('greet_hello', '/examples/greet_hello', {})

    storage.should have_static_view('/examples/greet_hello', 'Hello')
  end

  it 'disables forgery protection for static forms' do
    create_view('examples/form.html.erb', "<%= form_tag '/' do %><% end %>")
    renderer = Turning::Renderer.new('examples', mock_storage)
    expect { renderer.render_to_file('form', '/form', {}) }.not_to raise_error
  end

  it 'renders with a layout' do
    create_view('examples/simple.html.erb', 'Hello')
    create_view('layouts/static.html.erb', 'Check this: <%= yield %>')
    storage = mock_storage
    renderer = Turning::Renderer.new('examples', storage)
    renderer.render_to_file('simple', '/examples/simple', {})

    storage.should have_static_view('/examples/simple', 'Check this: Hello')
  end

  def mock_storage
    stub('storage', put: nil)
  end

  def have_static_view(path, contents)
    have_received(:put).with(path, contents)
  end
end
