require 'optparse'

module BeerList
  class CLI
    COMMANDS = %w(establish)

    class << self
      def start(args)
        options = parse ARGV

        msg = ARGV[0]
        abort unsupported_command unless COMMANDS.include? msg

        new(options).public_send msg
      end

      def parse(args)
        options = {}

        opts = OptionParser.new do |opts|
          opts.banner = "Usage: beer_list establish [options]"

          opts.on("-u", "--url [URL]", "url of your establishment's beer list") do |url|
            options[:url] = url
          end

          opts.on("-s", "--selector [SELECTOR]", "selector to use for scraping") do |s|
            options[:selector] = s
          end

          opts.on("-d", "--directory DIR", "the directory in which BeerList will put your establishments") do |dir|
            options[:dir] = dir
          end
        end

        opts.parse! args
        options
      end

      def unsupported_command
        <<-WARN
        Command: not supported. Must be one of the following:
        #{COMMANDS.join(', ')}
        WARN
      end

      def no_establishments_dir
        <<-WARN
        You must supply an establishments directory with -d or --directory
        WARN
      end
    end

    def initialize(args)
      @args = args
    end

    def establish(klass=ARGV[1])
      abort self.class.no_establishments_dir unless @args[:dir]
      # Support underscore and camelcase
      klass = klass.split('_').map(&:capitalize).join if klass.match(/_/)
      BeerList::EstablishmentGenerator.new(klass, @args)
    end
  end
end
