require 'erb'

module BeerList
  class EstablishmentGenerator
    
    DEFAULT_URL        = 'http://yourestablishment.com/path/to/the/beer_list'
    TEMPLATE_FILE      = File.expand_path('../templates/establishment.erb', __FILE__)
    ESTABLISHMENTS_DIR = File.expand_path('../../beer_list/establishments', __FILE__)

    def initialize(klass, args={})
      @klass     = klass
      @url       = args[:url] || DEFAULT_URL
      @selector  = args[:selector] || '.selector'
      @directory = args[:directory] || ESTABLISHMENTS_DIR
      write_file
    end

    private

    def write_file
      File.open(filepath, 'w+') do |f|
        f << template.result(binding)
      end
    end

    def template
      ERB.new File.open(TEMPLATE_FILE).read, nil, '-'
    end

    def filepath
      File.join @directory, "#{@klass.underscore}.rb"
    end
  end
end
