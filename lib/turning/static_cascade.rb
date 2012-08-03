module Turning
  class StaticCascade
    def initialize(app, storage)
      @app = app
      @storage = storage
    end

    def call(env)
      if body = @storage.get(env['PATH_INFO'])
        content_length = body.size
        headers = { 'Content-Type' => 'text/html', 'Content-Length' => content_length.to_s }
        [200, headers, [body]]
      else
        @app.call(env)
      end
    end
  end
end
