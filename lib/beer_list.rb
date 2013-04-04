require 'mechanize'
require 'json'

module BeerList
  require 'beer_list/scraper'
  require 'beer_list/establishments'
  require 'beer_list/list'

  class << self

    def scraper
      @scraper ||= Scraper.new
    end

    def method_missing(method, *args, &block)
      est = method.to_s.split('_').map(&:capitalize).join
      klass = ['BeerList', 'Establishments', est].compact.inject(Object){ |o, name| o.const_get(name) }
      scraper.beer_list klass.new
    end
  end
end
