class NoopWorker < ApplicationWorker
  def perform
    # Equivalent to SemanticLogger['NoopWorker'].info
    message_test = 'Start NoopWorker to test rails semantic logger issues'
    message_with_start = "Contains start, but shold not filtered, since doesn't come from Sidekiq itself. Comes from logger instance."
    puts "Via puts: #{message_test}"
    Rails.logger.info "Via logger: #{message_test}"
    puts "Via puts: #{message_with_start}"
    Rails.logger.info "Via logger: #{message_with_start}"

    # Equivalent to "Start #perform" logs.
    Sidekiq.logger.info 'start start. Filtered'
    Sidekiq.logger.info 'foo foo. Not filtered'
  end
end
