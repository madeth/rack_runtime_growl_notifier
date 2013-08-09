# RackRuntimeGrowlNotifier


## Installation

Add this line to your application's Gemfile:

    group :development do
      gem 'rack_runtime_growl_notifier', github: 'madeth/rack_runtime_growl_notifier'
    end

## Usage

Add setting code to `config/environments/development.rb`

    config.rack_runtime_growl_notifier.enable = true
    config.rack_runtime_growl_notifier.info = 100
    config.rack_runtime_growl_notifier.warning = 200
    config.rack_runtime_growl_notifier.error = 500


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
