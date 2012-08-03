require 'spec_helper'
require 'turning'

describe Turning do
  include Rack::Test::Methods

  it 'listens to events and renders the view to a static file' do
    create_file('app/listeners/examples_listener.rb', <<-RUBY)
      class ExamplesListener < Turning::Listener
        def listen
          Example.on_update do
            render 'index', '/', greeting: 'Hello'
          end
        end
      end
    RUBY

    create_file('app/models/example.rb', <<-RUBY)
      class Example
        def self.on_update(&block)
          @on_update = block
        end

        def self.trigger_update
          @on_update.call
        end
      end
    RUBY

    create_view('examples/index.html.erb', '<%= @greeting %>')

    Turning::ListenerLoader.load

    Example.trigger_update

    get '/'
    last_response.body.should == 'Hello'
  end

  def app
    TestApp::Application
  end
end
