$:.unshift File.dirname(__FILE__)     # adds current directory to load path
require 'setup'



class ArticlesPageWorker < CrawlerJobs::HTTPClientWorker

  def response(body)
    document = Nokogiri::HTML(body)


  end

end


ArticlesPageWorker.get_body('http://muenchen.bringmeister.de/obst-gemuse.html')
# NOTE: ArticlesPageWorker.post_body(url, params, headers) also exists