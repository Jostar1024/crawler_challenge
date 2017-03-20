# crawler_jobs


Provides crawler workers that work off configurable web crawling jobs.

Also provides tons of **visibility** / **system observability** into the crawling process.

See the [wiki](https://github.com/Simplora/crawler_jobs/wiki) for the library's **idea and goals**.


## Installation


Add this line to your application's Gemfile:

```ruby

gem 'crawler_jobs'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install crawler_jobs


## Usage

Define a subclass of `CrawlerJobs::HTTPClientWorker`. Its `#response` method will be called with the requested page's body in the respective worker thread when the request has finished. 

```ruby
require 'crawler_jobs'

class MyWorker < CrawlerJobs::HTTPClientWorker

  def response(body)
    # do something ( will be performed concurrently, or even in parallel )
  end
end

MyWorker.get_body('http://eatsmarter.de/')
```

Any additional arguments besides the URL will get passed unmodified.
```ruby
class MyWorker < CrawlerJobs::HTTPClientWorker

  def response(body, any, additional, args); end
end

MyWorker.get_body('http://eatsmarter.de/', any, additional, args)
```

## Running concurrently

For concurrently running the jobs in worker threads, a redis instance has to be running. Run it on the default port or see [Configuration](#configuration) on how to configure the redis instance that should be used.

Run a sidekiq worker process that requires all your crawlers.

    $ sidekiq -r ./crawlers.rb

When your crawling application now calls
```ruby
MyWorker.get_body('http://some.url')
```
it will be picked up and requested by a worker thread which passes the response body to the `#response` method.

## Running sequentially

* TODO: enable this to be configured.

## Monitoring

TBD
* TODO: add web UI monitoring

### Errors

### Metrics / Performance


## Retries / Timeout handling

TBD


## Configuration


TBD
* configure the proxy URL
* configure the redis URL


## Logging


* You can use tagged logging
* TBD


## Development

Usually, this library is (co-)developed while being used from an actual (example) crawling application.

If you want to experiment anyways, after checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment. You can use [direnv](http://direnv.net/) to get rid of the `bin/` prefixes.

See the [development wiki page](https://github.com/Simplora/crawler_jobs/wiki/Development) to learn about the principles and architecture of this library.


## Testing

(does not have tests so far)


## Next Steps

For immediate next steps, see the [issues](https://github.com/Simplora/crawler_jobs/issues).
