module Turning
  class FileStorage
    def initialize(root_path)
      @root_path = root_path
    end

    def put(file_path, contents)
      FileUtils.mkdir_p(parent_directory(file_path))
      File.open(resolve(file_path), 'w') do |file|
        file.write(contents)
      end
    end

    def get(file_path)
      begin
        IO.read(resolve(file_path))
      rescue Errno::ENOENT
        nil
      end
    end

    private

    def resolve(file_path)
      File.join(@root_path, file_path)
    end

    def parent_directory(file_path)
      File.dirname(resolve(file_path))
    end
  end
end
