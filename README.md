# Beer List

A utility for retrieving the beer list from various establishments

## Usage

### Installation

`gem install beer_list`

or in your gemfile:

`gem 'beer_list'`

then require the gem:

`require 'beer_list'`

### Getting a List

See what's on tap:

```ruby
# An array-like object
list = BeerList.groveland_tap

# As a hash
list.to_hash

# As JSON
list.to_json
```

### Establishments

Establishments peddle delicious beers. You're interested in which delicious beers a
given establishment is peddling. To reconcile this situation, you need one or more 
[establishments](#adding-establishments).

First, let's try one out of the box:

```ruby
bulldog_northeast = BeerList::Establishments::BulldogNortheast.new

# Now get the list
bulldog_northeast.list
```

You may want to get lists for more than one establishment at a time. To do so, register
the desired establishments in BeerList.establishments:

```ruby
three_squares = BeerList::Establishments::ThreeSquares.new
muddy_waters  = BeerList::Establishments::MuddyWaters.new

# Register establishments
BeerList.add_establishments(three_squares, muddy_waters)

# See your registered establishments
BeerList.establishments

# Get the beer lists at your registered establishments.
# as an array of BeerList::List objects
BeerList.lists

# As a hash
BeerList.lists_as_hash

# As JSON
BeerList.lists_as_json
```

The Lists will be memoized until the content of BeerList.establishments changes so that
the establishments don't have to be re-scraped each time the list is requested.

### Adding Establishments

BeerList includes an executable to easily create your own establishments.

For example:

`$ beer_list establish Applebirds -u http://applebirds.com/beers -d path/to/establishments`

will create the following code in path/to/establishments/applebirds.rb

```ruby
module BeerList
  module Establishments
    class Applebirds < Establishment
      URL     = 'http://applebirds.com/beers'
      ADDRESS = nil

      # Handles parsing and manipulating a Mechanize::Page object
      # in order to scrape the contents of your beer list.
      #
      # Uncomment and implement to your liking.
      def get_list
        # page.search('.selector').map(&:text)
      end

      def url
        URL
      end

      def address
        ADDRESS
      end
    end
  end
end

```

For all options you can pass to beer_list establish, run:

`$ beer_list help establish`

### Using Your Generated Establishments

So you've written some pretty bad-ass scrapers now, and you're ready to actually
use the fruit of your labor in a real application. You'll need to tell BeerList
about the generated files so that it can require them. If you're using Rails, add
the following code in an initializer:

```ruby
BeerList.configure do |c|
  c.establishments_dir = File.join(Rails.root, 'path/to/establishments')
end
```

Then in your app:

```ruby
# Fetch just the list at Applebirds
BeerList.applebirds

# Or, register your establishment
BeerList.add_establishment(BeerList::Establishments::Applebirds.new)

# fetch all your registered lists, including the one at Applebirds
BeerList.lists

```

See [Getting A List](#getting-a-list) for more details.

AND...

Checkout [this link](http://mechanize.rubyforge.org/) for more on Mechanize

### Sending Lists

Once you have lists, you can use them locally (obviously), or you can send them elsewhere.
Configure BeerList with a default URL like this:

```ruby
BeerList.configure do |c|
  c.default_url = 'https://yourapp.com/some_sweet_beer_route'
end
```

Then in your code, send a list!

```ruby
applebirds = BeerList.applebirds

# POSTs your list to your default_url as JSON under the "beer_list" name
BeerList.send_list(applebirds)

# You can also give it an explicit URL
other_route = 'http://myotherapp.com/another_beer_route'
BeerList.send_list(applebirds, other_route)

# Register some lists and send 'em all at once:
thursdays = BeerList::Establishments::Thursdays.new

BeerList.add_establishments(applebirds, thursdays)
BeerList.send_lists
```

Both .send_list and .send_lists accept an optional URL as the last argument. If you don't pass one,
it will use the default in your configuration. If neither exist, it will raise an error.

### Leads

If you're out of ideas on what establishments you may want lists for, fear not: BeerList can
give you some ideas.

```ruby
# You might be interested in good beer bars located in California:
cali = BeerList::Leads::CA.new

# returns a BeerList::List of URLs for popular beer bars in California
cali.list


# Maybe you want Wisconsin:
wi = BeerList::Leads:WI.new

wi.list

```

So far, support for this feature is limited to the United States. Hopefully, I can expand
it in the not-too-distant future.

### CLI

In addition to the [establish](#extending-beerlist-with-more-establishments) command, which
generates Establishment files for you, BeerList also offers a few other commands:

There's the `list` command. For example,
say you have the following two establishments a directory called ~/my_beer_lists:

```
applebirds.rb
thursdays.rb
```

You can get the beer lists for these places from the command line:

```
$ beer_list list applebirds -d ~/my_beer_lists

# or
$ beer_list list applebirds thursdays -d ~/my_beer_lists

# pass -j for JSON
$ beer_list list applebirds thursdays -j -d ~/my_beer_lists
```

There's also the `send` command for [sending your lists](#sending-lists) to a given URL:

`$ beer_list send applebirds thursdays -u 'http://mybeerapiendpoint.com/beer_list'`

See `$ beer_list help` for all commands
