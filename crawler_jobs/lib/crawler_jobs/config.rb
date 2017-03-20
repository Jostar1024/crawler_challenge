
require 'active_support/tagged_logging'
ActiveSupport::TaggedLogging.new(Sidekiq::Logging.logger)
Sidekiq::Logging.logger.level = Logger::INFO