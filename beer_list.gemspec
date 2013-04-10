Gem::Specification.new do |spec|
  spec.name          = 'beer_list'
  spec.version       = '0.1.0'
  spec.authors       = ['Dan Olson']
  spec.email         = ['olson_dan@yahoo.com']
  spec.description   = 'A utility for retrieving the beer list from various establishments'
  spec.summary       = 'A beer list scraper'
  spec.homepage      = 'https://github.com/DanOlson/beer_list'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'mechanize', '2.6.0'
  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rspec'
end
