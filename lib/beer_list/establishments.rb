$LOAD_PATH.unshift(File.dirname(__FILE__))

module BeerList
  module Establishments
    require 'establishments/establishment'

    Dir[File.dirname(__FILE__) + '/establishments/*.rb'].each do |f|
      require f.split('.rb').first
    end

    if BeerList.establishments_dir
      Dir[File.join(BeerList.establishments_dir, '*.rb')].each do |f|
        require f.split('.rb').first
      end
    end
  end
end
