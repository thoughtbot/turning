# Turning

A tiny framework to render views whenever data changes rather than re-rendering on every visit.

## Usage

Create a listener:

    # app/listeners/products_listener.rb
    class ProductsListener < Turning::Listener
      def listen
        Product.on(:save) do |product|
          render 'show', product_path(product), product: product
        end
      end
    end

Whenever a `Product` is saved, it will render the
`app/views/products/show.html.erb` view and save it in `public/static`. A Rack
middleware is included and autoconfigured to serve static pages from that
directory.

## Installation

Add this line to your application's Gemfile:

    gem 'turning'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install turning

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new pull request
