$LOAD_PATH.unshift(File.dirname(__FILE__))

module BeerList
  module Establishments
    require 'establishments/establishment'

    Dir[File.dirname(__FILE__) + '/establishments/*.rb'].each do |f|
      require f.split('.rb').first
    end
  end
end
