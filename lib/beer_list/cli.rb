require 'thor'

module BeerList
  class CLI < Thor
    option :url,
           aliases: '-u',
           banner:  "The URL of your establishment's beer list"
    option :directory,
           required: true,
           aliases:  '-d',
           banner:   'The directory in which BeerList will put your establishments'
    option :selector,
           aliases: '-s',
           banner: 'Optional selector to use for scraping'

    desc 'establish ESTABLISHMENT', 'Generate a subclass of BeerList::Establishments::Establishment in the given directory'
    def establish(klass)
      # Support underscore and camelcase
      klass = klass.split('_').map(&:capitalize).join if klass.match(/_/)
      BeerList::EstablishmentGenerator.new(klass, options)
    end

    option :directory,
           aliases:  '-d',
           banner:   'The directory where your establishments are stored'
    option :json,
           aliases: '-j',
           type: :boolean,
           banner:  'Format output as JSON'

    desc 'list ESTABLISHMENTS', 'Retrieve the beer list at the given establishments'
    def list(*establishments)
      BeerList.establishments_dir = options[:directory]
      BeerList.add_establishments *classify(establishments)
      if options[:json]
        puts BeerList.lists_as_json
      else
        BeerList.lists.each do |list|
          puts '*' * (list.establishment.size + 10)
          puts "**** #{list.establishment} ****"
          puts '*' * (list.establishment.size + 10)
          puts
          puts list
          puts
        end
      end
    end

    private

    def classify(establishments)
      establishments.map do |est|
        class_name = est.to_s.split('_').map(&:capitalize).join
        klass = ['BeerList', 'Establishments', class_name].inject(Object){ |o, name| o.const_get(name) }
        klass.new
      end
    end
  end
end
