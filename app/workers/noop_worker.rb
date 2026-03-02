class NoopWorker < ApplicationWorker
  def perform
    message_test = 'Start NoopWorker to test rails semantic logger issues'
    message_with_start = 'start, should be filtered, since comes from logger instance.'
    message_with_perform = 'Contains #perform, and should be filtered.'

    # No filtering applies to puts messages.
    puts "Via puts: #{message_test}"
    puts message_with_start
    puts "Via puts: #{message_with_perform}"

    # Equivalent to SemanticLogger['NoopWorker'].info, where "Start #perform" logs originate.
    Rails.logger.info "Via logger: #{message_test}"
    Rails.logger.info message_with_start
    Rails.logger.info "Via logger: #{message_with_perform}"

    # Equivalent to SemanticLogger['Sidekiq'].logger
    Sidekiq.logger.info 'start start. Filtered'
    Sidekiq.logger.info 'foo foo. Not filtered'
  end
end
