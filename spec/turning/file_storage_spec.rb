require 'spec_helper'
require 'turning/file_storage'

describe Turning::FileStorage do
  it 'returns the content of a file from the filesystem' do
    root = Rails.root.join('public', 'static')
    putter = Turning::FileStorage.new(root)
    getter = Turning::FileStorage.new(root)

    putter.put('examples/awesomeness.html', 'awesome!')
    results = getter.get('examples/awesomeness.html')

    results.should == 'awesome!'
  end

  it 'caches a file at the root' do
    root = Rails.root.join('public', 'static')
    storage = Turning::FileStorage.new(root)

    storage.put('/', 'awesome!')
    results = storage.get('/')

    results.should == 'awesome!'
  end

  it 'returns nil for a file that does not exist' do
    root = Rails.root.join('public', 'static')
    getter = Turning::FileStorage.new(root)

    getter.get('snakes').should be_nil
  end
end
