class NoopWorker < ApplicationWorker
  def perform
    puts 'Via puts: worker running noop worker to test rails semantic logger issues'
    Rails.logger.info 'Via logger: worker running noop worker to test rails semantic logger issues'

    puts 'Via puts: contains start . Should be filtered.'
    Rails.logger.info 'Via logger: contains start . Should be filtered.'

    # Log via SemanticLogger directly, scoped to NoopWorker (not Rails)
    # SemanticLogger['NoopWorker'].info 'Via SemanticLogger: NoopWorker logger test message'
  end
end
