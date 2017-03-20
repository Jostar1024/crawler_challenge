$:.unshift File.dirname(__FILE__)     # adds current directory to load path
require 'setup'
require 'json'


class ArticlesPageWorker < CrawlerJobs::HTTPClientWorker

  def response(body)

    # if Content-Type is application/json, with get_content we don't even
    # need to parse it using Nokogiri.

    # document = Nokogiri::HTML(body)
    # binding.pry
    # puts document

    # parse the response in json using css selector or xpath.
    # products = JSON.parse(document.css('p').text)
    # products = JSON.parse(document.xpath('//p').text)

    products = JSON.parse(body)
    # print the images' link on STDOUT
    for i in 0..59
        puts products['products'][i]['imageUrl']
    end

    open('test_' + Time::now.strftime('%Y%B%d_%H%M%S') + '.txt', 'a') { |f| 
        f << products['products'][0, 3]
    }
  end

end


# ArticlesPageWorker.get_body('http://berlin.bringmeister.de/obst-gemuse.html')
# NOTE: ArticlesPageWorker.post_body(url, params, headers) also exists




# "=>" here are read as "stands for"
# cat => catagory
# p => page
# pc => page count
# order => criteria for the ordering
# dir => asc or desc
# storeId I don't know
ArticlesPageWorker.post_body('http://berlin.bringmeister.de/fast-search/index.php/', {
    'cat' => '2323',
    'p' => '1',
    'pc' => '60',
    'order' => 'popularity_calculated',
    'dir' =>'desc',
    'storeId' => '1'
})

ArticlesPageWorker.post_body('http://berlin.bringmeister.de/fast-search/index.php/', {
    'cat' => '2323',
    'p' => '2',
    'pc' => '60',
    'order' => 'popularity_calculated',
    'dir' =>'desc',
    'storeId' => '1'
})