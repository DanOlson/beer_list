# Beer List

A utility for getting the beer list from various establishments

## Usage

`require 'beer_list'`

First, you need a scraper:
`scraper = BeerList::Scraper.new`

Next, choose an establishment:
`groveland = BeerList::Establishments::GrovelandTap.new`

See what's on tap (as JSON):
`scraper.beer_list(groveland)`
