
Bundler.require

# configures articles worker to function locally
class CrawlerJobs::HTTPClientWorker
  def self.perform_async(*args)
    self.new.perform(*args)
  end
end