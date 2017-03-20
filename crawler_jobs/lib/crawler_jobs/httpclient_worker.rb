
module CrawlerJobs
  # # delays in secs
  # # TODO: make configurable
  DELAYS = { :'eatsmarter.de' => 0.5, :'api.chefkoch.de' => 0.02 }

  class << self
    attr_accessor :proxy_url

    # uses a client per process, but same for all the process' respective threads
    def client
      @client ||= HTTPClient.new(proxy_url, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36')
    end

    # # TODO: use Mutex for this purpose instead !!   ( I think `connection_pool` is not really what we are looking for for this use-case. )
    # # this simply hands the CPU to some other thread until a configurable time has passed for the respective domain
    # # if one domain is throttled more than another it is likely that it keeps the other from running as fast as it could
    # # ( if that becomes the case, we could introduce multiple queues for fast, medium, and slow domains for example )
    # # not safe to be used in a non-MRI ruby (specifically JRuby)
    def client_for(domain, logger)
      domain = domain.to_sym
      @last_request ||= {}
      @last_request[domain] ||= Time.new(0)
      tm = 0
      until Time.now - @last_request[domain] >= DELAYS[domain]
        tm += 0.1
        sleep(0.1) # sleep 100 ms
      end
      @last_request[domain] = Time.now
      logger.info "returning client for #{domain} after #{tm} seconds"
      client
    end

  end

  class HTTPClientWorker
    include ::Sidekiq::Worker

    sidekiq_options retry: 5, dead: true

    sidekiq_retry_in do |count|
      4 * (count + 1) # (i.e. 4,8,12,16,20)
    end

    # sidekiq_retries_exhausted do |msg|; end # TODO.

    class << self

      def get_body(url, *args)
        perform_async(:get, url, *args)
      end

      def post_body(url, params, *args)
        perform_async(:post, url, params, *args)
      end
    end

    def client
      CrawlerJobs.client
    end

    def perform(method, url, *args)
      uri = URI.parse(url)
      if method.to_sym == :get
        # #get_content() automatically follows redirects. raises on non-2XX response
        response(client.get_content(uri), *args)
      elsif method.to_sym == :post
        params  = args[0]
        headers = args[1]
        response(client.post_content(uri, params, headers), *args[2..args.length])
      else
        raise "unknown method #{method}"
      end
    end

  end
end
