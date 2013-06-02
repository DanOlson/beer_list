module BeerList
  module Establishments
    class Establishment
      include BeerList::Listable

      def name
        self.class.name.split('::').last.split(/(?=[A-Z])/).join(' ')
      end
    end
  end
end
