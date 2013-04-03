# Beer List

A utility for retrieving the beer list from various establishments

## Usage

`require 'beer_list'`

Choose an establishment:

`groveland = BeerList::Establishments::GrovelandTap.new`

See what's on tap (as JSON):

`BeerList.scraper.beer_list(groveland)`
