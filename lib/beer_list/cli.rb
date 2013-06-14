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
           banner:  'Optional selector to use for scraping'
    option :address,
           aliases: '-a',
           banner:  'The physical address of your establishment'

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
      configure
      add_establishments establishments
      if options[:json]
        puts BeerList.lists_as_json
      else
        BeerList.lists.each do |list|
          puts '*' * (list.listable_name.size + 10)
          puts "**** #{list.listable_name} ****"
          puts '*' * (list.listable_name.size + 10)
          puts
          puts list
          puts
        end
      end
    end

    option :url,
           aliases:  '-u',
           required: true,
           banner:   'the URL to which to post your lists'
    desc 'send ESTABLISHMENTS', 'Send (POST) the lists (as JSON) for the given establishments to the given URL'
    def send(*establishments)
      configure
      add_establishments establishments
      puts "Sent!" if BeerList.send_lists
    end

    private

    def add_establishments(establishments)
      BeerList.add_establishments *classify(establishments)
    end

    def configure
      BeerList.configure do |c|
        c.establishments_dir = options[:directory]
        c.default_url        = options[:url]
      end
    end

    def classify(establishments)
      establishments.map do |est|
        class_name = est.to_s.split('_').map(&:capitalize).join
        instantiate_or_die class_name
      end
    end

    def instantiate_or_die(class_name)
      if klass = BeerList.send(:get_class_with_namespace, class_name)
        klass.new
      else
        abort "#{class_name} is not recognized. Is it in your BeerList.establishments_dir?"
      end
    end
  end
end
