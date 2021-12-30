# TODO: Write documentation for `Iobot`
require "clim"
require "yaml"

require "./configuration"

module Iobot
  VERSION = "0.1.0"

  DESCRIPTION = "iobot - a simple discord bot using iolite"

  class CLI < Clim
    main do
      desc DESCRIPTION
      usage "iobot [options]"
      help short: "-h"
      version "iobot: version iobot-#{Iobot::VERSION}", short: "-v"

      run do |opts, args|
        puts version
        puts "#{args.all_args.join(", ")}!"

        config = Configuration.new
        p config
        p config.config
      end
    end
  end
end

Iobot::CLI.start(ARGV) unless Iobot.responds_to?(:should)
