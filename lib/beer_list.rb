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
      true
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
      lists.map &:to_hash
    end

    def lists_as_json
      lists.map &:to_json
    end

    def send_list(list, url=nil)
      url ||= default_url
      raise NoUrlError unless url
      raise NotAListError unless list.is_a? BeerList::List
      scraper.send_json url, [list.to_json]
    end

    def send_lists(url=nil)
      url ||= default_url
      raise NoUrlError unless url
      scraper.send_json url, lists_as_json
    end

    def scraper
      @scraper ||= Scraper.instance
    end

    def establishment_instances
      establishment_classes.map do |e|
        get_class_with_namespace e
      end.map &:new
    end

    private

    def establishment_classes
      BeerList::Establishments.constants.reject { |c| c == :Establishment }
    end

    def update_necessary?
      !@lists || !establishments_eq_lists?
    end

    def _establishments
      @establishments ||= []
    end

    def establishments_eq_lists?
      list_names = @lists.map { |list| list.listable_name }
      establishments.map(&:name).all? { |name| list_names.include? name }
    end

    def method_missing(method, *args, &block)
      class_name = method.to_s.split('_').map(&:capitalize).join
      if klass = get_class_with_namespace(class_name)
        scraper.beer_list klass.new
      else
        super
      end
    end

    def respond_to_missing?(method, include_private=false)
      class_name = method.to_s.split('_').map(&:capitalize).join
      !!get_class_with_namespace(class_name) || super
    end if RUBY_VERSION >= '1.9'

    def respond_to?(method, include_private=false)
      class_name = method.to_s.split('_').map(&:capitalize).join
      !!get_class_with_namespace(class_name) || super
    end if RUBY_VERSION < '1.9'

    def is_establishment?(class_name)
      establishment_classes.include? class_name
    end

    def get_class_with_namespace(class_name)
      return nil unless is_establishment? class_name
      ['BeerList', 'Establishments', class_name].inject(Object){ |o, name| o.const_get(name) }
    end
  end
end
