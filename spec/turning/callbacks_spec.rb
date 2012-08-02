require 'spec_helper'
require 'turning/callbacks'

describe Turning, 'callbacks' do
  it 'runs a callback without mangling self' do
    model_class = Class.new do
      extend ActiveModel::Callbacks
      define_model_callbacks :save
    end
    ran_with = nil

    model_class.on(:save) do
      ran_with = self
    end

    model = model_class.new
    model.run_callbacks(:save)

    ran_with.object_id.should == self.object_id
  end
end
