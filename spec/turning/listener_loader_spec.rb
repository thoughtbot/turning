require 'spec_helper'
require 'turning/listener_loader'

describe Turning::ListenerLoader do
  it 'loads listeners' do
    create_file('app/listeners/examples_listener.rb', <<-RUBY)
      class ExamplesListener
        def self.listening?
          defined?(@@listening) && @@listening
        end

        def listen
          @@listening = true
        end
      end
    RUBY

    Turning::ListenerLoader.load

    ExamplesListener.should be_listening
  end
end
