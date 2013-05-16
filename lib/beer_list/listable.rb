module BeerList
  module Listable
    attr_accessor :page

    def list
      visit_page unless page
      @list ||= BeerList::List.new establishment: short_class_name, array: get_list
    end

    def short_class_name
      raise NotImplementedError
    end

    def get_list
      raise NotImplementedError
    end

    private

    def visit_page
      BeerList.scraper.visit self
    end
  end
end
