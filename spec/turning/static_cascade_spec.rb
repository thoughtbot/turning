require 'spec_helper'
require 'turning/static_cascade'

describe Turning::StaticCascade do
  it 'serves the file if it exists' do
    app = stub('app')
    fake_content_storage = stub('fake content storage', get: 'contents')
    static_file_name = '/ponies'
    static_cascade = Turning::StaticCascade.new(app, fake_content_storage)

    response = static_cascade.call('PATH_INFO' => static_file_name)
    fake_content_storage.should have_received(:get).with(static_file_name)
    response.should == [
      200,
      { 'Content-Type' => 'text/html', 'Content-Length' => 'contents'.size.to_s },
      ['contents']
    ]
  end

  it 'cascades if the file does not exist' do
    app = stub('app', call: 'app response')
    fake_content_storage = stub('fake content storage', get: nil)
    env = { 'PATH_INFO' => '/ponies' }
    static_cascade = Turning::StaticCascade.new(app, fake_content_storage)

    response = static_cascade.call(env)

    app.should have_received(:call).with(env)
    response.should == 'app response'
  end
end
