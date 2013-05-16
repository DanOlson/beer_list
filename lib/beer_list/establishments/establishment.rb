module BeerList
  module Establishments
    class Establishment
      include BeerList::Listable

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
