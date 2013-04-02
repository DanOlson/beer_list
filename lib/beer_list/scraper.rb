class Scraper
  attr_reader :agent, :url, :page

  USER_AGENT = 'Mac Safari'
  
  def initialize(url)
    @url   = url
    @agent = Mechanize.new
    post_init
  end

  def post_init
    set_user_agent
    visit_site
  end

  def visit_site
    @page = agent.get(url)
  end

  def set_user_agent
    agent.user_agent_alias = USER_AGENT
  end
end
