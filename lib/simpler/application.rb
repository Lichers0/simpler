require 'yaml'
require 'singleton'
require 'sequel'
require_relative 'router'
require_relative 'controller'

module Simpler
  class Application

    include Singleton

    attr_reader :db

    def initialize
      @router = Router.new
      @db = nil
    end

    def bootstrap!
      setup_database
      require_app
      require_routes
    end

    def routes(&block)
      @router.instance_eval(&block)
    end

    def call(env)
      route = @router.route_for(env)
      unless route
        create_log_info_not_found(env)
        return not_found
      end

      controller = route.controller.new(env)
      action = route.action

      make_response(controller, action)
    end

    private

    def require_app
      Dir["#{Simpler.root}/app/**/*.rb"].each { |file| require file }
    end

    def require_routes
      require Simpler.root.join('config/routes')
    end

    def setup_database
      database_config = YAML.load_file(Simpler.root.join('config/database.yml'))
      database_config['database'] = Simpler.root.join(database_config['database'])
      @db = Sequel.connect(database_config)
    end

    def make_response(controller, action)
      controller.make_response(action)
    end

    def not_found
      Rack::Response.new(["Not Found"], 404, { "Content-Type" => "text/plain" }).finish
    end

    def create_log_info_not_found(env)
      @request = Rack::Request.new(env)
      env['Simpler.Log.Request'] =
        "Request: #{@request.request_method} #{@request.fullpath}"

      env['Simpler.Log.Handler'] = "Handler: Not Found"

      env['Simpler.Log.Parameters'] = "Parameters: "

      env['Simpler.Log.Response'] =
        "Response: 404 [text/plain] Not Found"
    end
  end
end
