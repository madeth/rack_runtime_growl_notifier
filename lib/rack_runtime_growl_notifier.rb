# coding: utf-8
require "rack_runtime_growl_notifier/version"
require "rack_runtime_growl_notifier/rack"
require "rack/runtime"

module RackRuntimeGrowlNotifier
  if defined? ::Rails::Railtie
    class RackRuntimeGrowlNotifierRailtie < ::Rails::Railtie

      config.rack_runtime_growl_notifier = ActiveSupport::OrderedOptions.new
      config.rack_runtime_growl_notifier.enable = false
      config.rack_runtime_growl_notifier.info = 0
      config.rack_runtime_growl_notifier.warning = 200
      config.rack_runtime_growl_notifier.error = 500
      config.rack_runtime_growl_notifier.sticky = false
      config.rack_runtime_growl_notifier.priority = -2

      initializer "rack_runtime_growl_notifier.configure_rails_initialization" do |app|
        app.middleware.insert_before ::Rack::Runtime, ::RackRuntimeGrowlNotifier::Rack
      end
    end
  end
end
