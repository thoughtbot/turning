require 'spec_helper'
require 'turning'

describe Turning do
  include Rack::Test::Methods

  it 'listens to events and renders the view to a static file' do
    controller_class = Class.new(Turning::Controller) do
      def initialize(model)
        super()
        @model = model
      end

      def self.name
        'ExamplesController'
      end

      def listen
        @model.on_update do
          render 'index', '/', greeting: 'Hello'
        end
      end
    end

    model_class = Class.new do
      def on_update(&block)
        @on_update = block
      end

      def trigger_update
        @on_update.call
      end
    end

    create_view('examples/index.html.erb', '<%= @greeting %>')

    model = model_class.new
    controller = controller_class.new(model)

    controller.listen
    model.trigger_update

    get '/'
    last_response.body.should == 'Hello'
  end

  def app
    TestApp::Application
  end
end
