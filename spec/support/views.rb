module Views
  def create_view(path, contents)
    full_path = Rails.root.join('app', 'views', path)
    FileUtils.mkdir_p(File.dirname(full_path))
    File.open(full_path, 'w') { |file| file.write(contents) }
    @view_files ||= []
    @view_files << full_path
  end

  def read_static_view(path)
    IO.read(Rails.root.join('public', 'static', path))
  end

  def cleanup_views
    (@view_files || []).each do |view_file|
      FileUtils.rm_rf(view_file)
    end

    FileUtils.rm_rf(Rails.root.join('public', 'static'))
  end
end

RSpec.configure do |config|
  config.include Views

  config.after(:each) { cleanup_views }
end
