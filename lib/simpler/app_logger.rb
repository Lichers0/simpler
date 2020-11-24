require 'logger'
require 'dotenv/load'

module Simpler
  class AppLogger
    def initialize(app)
      @app = app
      @logger = Logger.new(ENV['LOGFILE'] || STDOUT)
    end

    def call(env)
      status, header, body = @app.call(env)

      save_log_info(env)
      response = Rack::Response.new(body, status, header)
      response.finish
    end

    def save_log_info(env)
      log_info = "\n#{env['Simpler.Log.Request']}\n"
      log_info += "#{env['Simpler.Log.Handler']}\n"
      log_info += "#{env['Simpler.Log.Parameters']}\n"
      log_info += "#{env['Simpler.Log.Response']}\n"
      @logger.info(log_info)
    end
  end
end
