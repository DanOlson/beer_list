module BeerList
  module Establishments
    class Establishment
      attr_accessor :scraper, :page, :list

      def set_scraper(scraper)
        @scraper = scraper
      end

      def to_json
        JSON.dump(self.class.name => get_list)
      end

      def url
        raise "#{__method__} is not implemented in #{self.class.name}"
      end
    end
  end
end
