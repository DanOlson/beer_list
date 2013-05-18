require 'mechanize'
require 'json'

module BeerList
  require 'beer_list/settings'
  require 'beer_list/scraper'
  require 'beer_list/list'
  require 'beer_list/exceptions'
  require 'beer_list/cli'
  require 'generators/establishment_generator'
  require 'ext/string'
  require 'beer_list/listable'
  require 'beer_list/leads/beer_advocate'
  autoload :Establishments, 'beer_list/establishments'

  class << self

    def configure
      yield settings
      self
    end

    def settings
      @settings ||= Settings.new
    end

    def default_url
      settings.default_url
    end

    def establishments_dir
      settings.establishments_dir
    end

    def establishments_dir=(directory)
      settings.establishments_dir = directory
    end

    def establishments
      return [] if @establishments.nil?
      @establishments.dup
    end

    def clear_establishments!
      @establishments.clear if @establishments
    end

    def add_establishment(*args)
      args.each do |e|
        _establishments << e if e.respond_to?(:get_list)
      end
    end
    alias :add_establishments :add_establishment

    def lists
      raise NoEstablishmentsError if establishments.empty?

      return @lists unless update_necessary?
      @lists = establishments.map do |e|
        scraper.beer_list e
      end
    end

    def lists_as_hash
      lists.inject({}) do |hsh, list|
        hsh.merge! list.to_hash
      end
    end

    def lists_as_json
      lists_as_hash.to_json
    end

    def scraper
      @scraper ||= Scraper.instance
    end

    private

    def update_necessary?
      !@lists || !establishments_eq_lists?
    end

    def _establishments
      @establishments ||= []
    end

    def establishments_eq_lists?
      list_names = @lists.map(&:establishment)
      establishments.map(&:short_class_name).all? { |name| list_names.include? name }
    end

    def method_missing(method, *args, &block)
      class_name = method.to_s.split('_').map(&:capitalize).join
      klass = get_class_with_namespace class_name
      scraper.beer_list klass.new
    end

    def get_class_with_namespace(class_name)
      ['BeerList', 'Establishments', class_name].inject(Object){ |o, name| o.const_get(name) }
    end
  end
end
