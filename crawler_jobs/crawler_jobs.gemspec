# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crawler_jobs/version'

Gem::Specification.new do |spec|
  spec.name          = 'crawler_jobs'
  spec.version       = CrawlerJobs::VERSION
  spec.authors       = ['Hendrik Wermser']
  spec.email         = ['hendrik@simplora.de']

  spec.summary       = %q{ Write a short summary, because Rubygems requires one.}
  spec.description   = %q{ Write a longer description or delete this line.}
  spec.homepage      = 'http://www.rezeptshopping.de'

  # Prevents pushing this gem to RubyGems.org
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://gembox.simplora.de'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'sidekiq', '~> 4.1'
  spec.add_dependency 'httpclient', '~> 2.8'
  spec.add_dependency 'activesupport', '~> 4.1'

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'pry'
end
