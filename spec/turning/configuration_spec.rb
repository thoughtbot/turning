require 'spec_helper'
require 'turning/configuration'
require 'turning/file_storage'

describe Turning::Configuration do
  it 'has a default storage backend' do
    storage = stub('storage')
    Turning::FileStorage.stubs(new: storage)
    configuration = Turning::Configuration.new
    configuration.storage.should == storage
    Turning::FileStorage.should have_received(:new).with(Rails.root.join('public/static'))
  end

  it 'can change the storage backend' do
    configuration = Turning::Configuration.new
    configuration.storage = :anything
    configuration.storage.should == :anything
  end
end
