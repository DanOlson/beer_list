require 'erb'

module BeerList
  class EstablishmentGenerator
    attr_reader :klass, :url, :selector
    
    DEFAULT_URL   = 'http://yourestablishment.com/path/to/the/beer_list'
    TEMPLATE_FILE = File.expand_path('../templates/establishment.erb', __FILE__)
    ESTABLISHMENTS_DIR = File.expand_path('../../beer_list/establishments', __FILE__)

    def initialize(args={})
      @klass    = args[:klass]
      @url      = args[:url] || DEFAULT_URL
      @selector = args[:selector] || '.selector'
    end

    def write_file
      File.open(filepath, 'w+') do |f|
        f << template.result(binding)
      end
    end

    def template
      ERB.new File.open(TEMPLATE_FILE).read, nil, '-'
    end

    def filepath
      File.join ESTABLISHMENTS_DIR, "#{klass.underscore}.rb"
    end
  end
end
