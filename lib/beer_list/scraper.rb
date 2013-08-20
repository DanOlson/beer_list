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
      visitable.page = agent.get(visitable.url)
    end

    def send_json(url, json)
      url = "http://#{url}" unless url.start_with? 'http'
      agent.post url, %({"beer_list": #{json}}), 'Content-Type' => 'application/json'
      true
    end

    private

    def set_user_agent
      agent.user_agent_alias = USER_AGENT
    end

    def agent
      @agent
    end
  end
end
