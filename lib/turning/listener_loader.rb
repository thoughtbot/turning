module Turning
  class ListenerLoader
    def self.load
      Dir.glob(Rails.root.join('app', 'listeners', '**', '*.rb')).each do |listener_file|
        Kernel.load(listener_file)
        listener_class = File.basename(listener_file).gsub('.rb', '').classify.constantize
        listener_class.new.listen
      end
    end
  end
end
