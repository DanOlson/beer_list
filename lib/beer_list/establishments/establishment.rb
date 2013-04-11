module BeerList
  module Establishments
    class Establishment
      attr_accessor :scraper, :page

      def list
        raise BeerList::NoScraperError unless @scraper
        @list ||= BeerList::List.new establishment: short_class_name, array: get_list
      end

      def get_list
        raise "#{__method__} is not implemented in #{self.class.name}"
      end

      def url
        raise "#{__method__} is not implemented in #{self.class.name}"
      end

      def short_class_name
        self.class.name.split('::').last
      end
    end
  end
end
