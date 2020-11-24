require_relative 'config/environment'
require_relative 'lib/simpler/app_logger'

use Rack::Reloader
use Simpler::AppLogger
run Simpler.application
