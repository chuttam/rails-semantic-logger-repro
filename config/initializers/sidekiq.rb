# Configure Sidekiq to work with rails_semantic_logger
Sidekiq.configure_server do |config|
  # Configure Redis connection (uses REDIS_URL environment variable if set)
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  # Use Semantic Logger for Sidekiq server logging
  config.logger = SemanticLogger['Sidekiq']
end

Sidekiq.configure_client do |config|
  # Configure Redis connection (uses REDIS_URL environment variable if set)
  config.redis = { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  # Use Semantic Logger for Sidekiq client logging
  config.logger = SemanticLogger['Sidekiq']
end

