$:.unshift File.dirname(__FILE__)     # adds current directory to load path
require 'setup'



class ArticlesPageWorker < CrawlerJobs::HTTPClientWorker

  def response(body)
    document = Nokogiri::HTML(body)

    binding.pry

    puts document
  end

end


ArticlesPageWorker.get_body('http://berlin.bringmeister.de/obst-gemuse.html')
# NOTE: ArticlesPageWorker.post_body(url, params, headers) also exists