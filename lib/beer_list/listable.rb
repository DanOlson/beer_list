module BeerList
  module Listable
    attr_accessor :page

    def list
      visit_page unless page
      @list ||= BeerList::List.new establishment: short_class_name, array: get_list
    end

    private

    def visit_page
      BeerList.scraper.visit self
    end
  end
end
