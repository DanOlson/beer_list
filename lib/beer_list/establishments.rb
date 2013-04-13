module BeerList
  module Establishments
    require 'beer_list/establishments/establishment.rb'

    Dir[File.dirname(__FILE__) + '/establishments/*.rb'].each { |f| require f }

    if BeerList.establishments_dir
      Dir[File.join(BeerList.establishments_dir, '*.rb')].each { |f| require f }
    end
  end
end
