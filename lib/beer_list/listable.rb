module BeerList
  module Listable
    attr_accessor :page

    # Templates
    [:get_list, :url, :address, :name].each do |m|
      define_method m do
        nil
      end
    end

    def list
      visit_page unless page
      @list ||= BeerList::List.new listable: self, array: get_list || []
    end

    private

    def visit_page
      BeerList.scraper.visit self
    end
  end
end
