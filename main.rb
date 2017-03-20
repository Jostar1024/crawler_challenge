$:.unshift File.dirname(__FILE__)     # adds current directory to load path
require 'setup'
require 'json'

class ArticlesJSONWorker < CrawlerJobs::HTTPClientWorker


    def response(response)
        products_first = JSON.parse(response)

        products_first['products'].each { |p| 
            puts p['imageUrl']
        }
    end

end


class ArticlesPageWorker < CrawlerJobs::HTTPClientWorker

  def response(body)

    # if Content-Type is application/json, with get_content we don't even
    # need to parse it using Nokogiri.

    document = Nokogiri::HTML(body)

    # puts document

    # This contents contain the url and storeId that we concern.
    script_contain_url_storeId = document.css('head script:contains("bm")').text

    # get all the neccessary information.
    page_count = 60
    search_url = script_contain_url_storeId.match("FAST_SEARCH:\s'(.+)'")[1]
    storeId = script_contain_url_storeId.match("SUGGESTER_SEARCH:\s'.+storeId=(.+)'")[1]
    binding.pry
    
    category = JSON.parse(document.css('script:contains("kategorie")').to_s.match('category\":({.+})}')[1])

    # "=>" here are read as "stands for"
    # cat => catagory
    # p => page
    # pc => page count
    # order => criteria for the ordering
    # dir => asc or desc
    # storeId I don't know
    response_first = ArticlesJSONWorker.post_body(URI(search_url).to_s, {
        'cat' => category['id'],
        'p' => '1',
        'pc' => page_count.to_s,
        'order' => 'popularity_calculated',
        'dir' =>'desc',
        'storeId' => storeId.to_s
    })

    response_second = ArticlesJSONWorker.post_body(URI(search_url).to_s, {
        'cat' => category['id'],
        'p' => '2',
        'pc' => page_count.to_s,
        'order' => 'popularity_calculated',
        'dir' =>'desc',
        'storeId' => storeId.to_s
    })

    open('file.txt', 'a') { |f| 
        f << body
    }


    # open('test_' + Time::now.strftime('%Y%B%d_%H%M%S') + '.txt', 'a') { |f| 
    #     f << products['products'][0, 3]
    # }
  end

end


ArticlesPageWorker.get_body('http://berlin.bringmeister.de/obst-gemuse.html')
# NOTE: ArticlesPageWorker.post_body(url, params, headers) also exists

