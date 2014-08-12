module BeerList
  module Establishments
    class Establishment
      include BeerList::Listable

      def name
        class_name = self.class.name.split('::').last
        class_name.split(/([A-Z]{1}[a-z]+)/).reject(&:empty?).join(' ')
      end
    end
  end
end
