require 'test/unit'

class TestArticlesPageWorker
    def test_response
        ArticlesPageWorker.post_body('http://berlin.bringmeister.de/fast-search/index.php/', {
            'cat' => '2323',
            'p' => '1',
            'pc' => '60',
            'order' => 'popularity_calculated',
            'dir' =>'desc',
            'storeId' => '1'
        })

    end
end