require 'spec_helper'
require 'turning/renderer'

describe Turning::Renderer do
  it 'renders to a file' do
    create_view('examples/say_hello.html.erb', '<%= @greeting %>')
    renderer = Turning::Renderer.new('examples')
    renderer.render_to_file('say_hello', greeting: 'Hello')

    read_cached_view('examples/say_hello.html').should include 'Hello'
  end

  it 'supplies built-in helpers' do
    create_view('examples/go_home.html.erb', '<%= link_to "go home", root_path %>')
    renderer = Turning::Renderer.new('examples')
    renderer.render_to_file('go_home', {})

    read_cached_view('examples/go_home.html').should match(%r{<a href=".*">go home</a>})
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
    renderer = Turning::Renderer.new('examples')
    renderer.render_to_file('greet_hello', {})

    read_cached_view('examples/greet_hello.html').should include 'Hello'
  end

  it 'disables forgery protection for static forms' do
    create_view('examples/form.html.erb', "<%= form_tag '/' do %><% end %>")
    renderer = Turning::Renderer.new('examples')
    expect { renderer.render_to_file('form', {}) }.not_to raise_error
  end

  it 'renders with a layout' do
    create_view('examples/simple.html.erb', 'Hello')
    create_view('layouts/static.html.erb', 'Check this: <%= yield %>')
    renderer = Turning::Renderer.new('examples')
    renderer.render_to_file('simple', {})

    read_cached_view('examples/simple.html').should == 'Check this: Hello'
  end
end
