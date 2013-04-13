require 'singleton'

module BeerList
  class Scraper
    include Singleton

    USER_AGENT = 'Mac Safari'

    def initialize
      @agent = Mechanize.new
      set_user_agent
    end

    def beer_list(establishment)
      visit establishment
      establishment.list
    end

    def visit(visitable)
      visitable.page = @agent.get(visitable.url)
    end

    private

    def set_user_agent
      @agent.user_agent_alias = USER_AGENT
    end
  end
end
