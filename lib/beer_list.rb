require 'mechanize'
require 'json'

module BeerList
  require 'beer_list/scraper'
  require 'beer_list/establishments'
  require 'beer_list/list'
  require 'beer_list/exceptions'
  require 'generators/establishment_generator'
  require 'ext/string'

  class << self

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

    private

    def scraper
      @scraper ||= Scraper.new
    end

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
      begin
        klass = ['BeerList', 'Establishments', class_name].compact.inject(Object){ |o, name| o.const_get(name) }
        scraper.beer_list klass.new
      rescue NameError
        super method, *args, &block
      end
    end
  end
end
