module Files
  def create_file(path, content)
    full_path = Rails.root.join(path)
    FileUtils.mkdir_p(File.dirname(full_path))
    File.open(full_path, 'w') { |file| file.write(content) }
    @files ||= []
    @files << full_path
  end

  def cleanup_files
    (@files || []).each do |file|
      FileUtils.rm_rf(file)
    end
  end
end

RSpec.configure do |config|
  config.include Files

  config.after(:each) { cleanup_files }
end
