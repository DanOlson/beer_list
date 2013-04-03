module BeerList
  class Scraper
    attr_reader :agent, :url, :page

    USER_AGENT = 'Mac Safari'

    def initialize
      @agent = Mechanize.new
      set_user_agent
    end

    def beer_list(establishment)
      establishment.set_scraper self
      visit_site establishment
      establishment.to_json
    end

    private

    def visit_site(establishment)
      establishment.page = agent.get(establishment.url)
    end

    def set_user_agent
      agent.user_agent_alias = USER_AGENT
    end
  end
end
