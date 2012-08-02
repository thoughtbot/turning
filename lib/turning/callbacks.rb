module ActiveModel::Callbacks
  def on(event, &block)
    new_block = lambda { |instance| block.call(instance) }
    send(:"after_#{event}", &new_block)
  end
end
