# coding: utf-8
require "growl"

module RackRuntimeGrowlNotifier
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      @config = RackRuntimeGrowlNotifier::RackRuntimeGrowlNotifierRailtie.config.rack_runtime_growl_notifier
      return @app.call(env) unless @config.enable

      status, headers, body = @app.call(env)

      if defined?(::Growl)
        x_runtime = headers["X-Runtime"] || 0
        db_runtime = env["action_controller.instance"].instance_variable_get(:@_db_runtime) || 0 rescue 0
        view_runtime = env["action_controller.instance"].instance_variable_get(:@_view_runtime) || 0 rescue 0

        if view_runtime > 0
          level = case headers["X-Runtime"].to_f * 1000
            when error?; :error
            when warning?; :warning
            when info?; :info
            else nil
            end
          message = "X-Runtime: %.4f sec \n(View: %.2f ms, DB: %.2f ms)"%[x_runtime, view_runtime, db_runtime]
          ::Growl.send("notify_#{level}", message, {title: env["PATH_INFO"], image: nil, name: self.class.to_s}) unless level.nil?
        end
      end
      [status, headers, body]
    end

    private

      def error?
        -> runtime { runtime > @config.error }
      end

      def warning?
        -> runtime { runtime > @config.warning }
      end

      def info?
        -> runtime { runtime > @config.info }
      end
  end
end
