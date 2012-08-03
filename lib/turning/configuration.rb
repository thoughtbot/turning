module Turning
  class Configuration
    attr_writer :storage

    def storage
      @storage ||= FileStorage.new(Rails.root.join('public', 'static'))
    end
  end
end
