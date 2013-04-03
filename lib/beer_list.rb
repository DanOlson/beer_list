require 'mechanize'
require 'json'

module BeerList
  require 'beer_list/scraper'
  require 'beer_list/establishments'

  class << self

    def scraper
      @scraper ||= Scraper.new
    end
  end
end
