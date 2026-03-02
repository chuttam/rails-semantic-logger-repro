# Configure Sidekiq to work with rails_semantic_logger
Sidekiq.configure_server do |config|
  # Configure Redis connection (uses REDIS_URL environment variable if set)
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  sidekiq_logger = SemanticLogger['Sidekiq']
  config.logger = sidekiq_logger
end

Sidekiq.configure_client do |config|
  # Configure Redis connection (uses REDIS_URL environment variable if set)
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
end

# Appender filters apply to all logs emanating from all loggers
# (e.g. from SemanticLogger[<WorkerClassName>].logger, and also Sidekiq.logger)
log_filter_regex = /\A(start|done|completed).*\z/i
# log_filter_regex = /#perform/i
SemanticLogger.appenders.each { |appender| appender.filter = ->(log) { log.message !~ log_filter_regex } }
