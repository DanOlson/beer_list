require 'thor'

module BeerList
  class CLI < Thor
    option :url,
           aliases: '-u',
           banner:  "url of your establishment's beer list"
    option :directory,
           required: true,
           aliases:  '-d',
           banner:   'the directory in which BeerList will put your establishments'
    option :selector,
           aliases: '-s',
           banner: 'selector to use for scraping'

    desc 'establish ESTABLISHMENT', 'Generates a subclass of BeerList::Establishments::Establishment in the given directory'
    def establish(klass)
      # Support underscore and camelcase
      klass = klass.split('_').map(&:capitalize).join if klass.match(/_/)
      BeerList::EstablishmentGenerator.new(klass, options)
    end
  end
end
