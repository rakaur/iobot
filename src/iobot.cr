# TODO: Write documentation for `Iobot`
require "clim"
require "totem"

require "iolite"

module Iobot
  VERSION = "0.1.0"

  DESCRIPTION = "iobot - a simple irc bot using iolite"

  class CLI < Clim
    main do
      desc DESCRIPTION
      usage "iobot [options]"
      version "iobot: version iobot-#{Iobot::VERSION}", short: "-v"

      help short: "-h"

      option "-c FILE", "--config=FILE", type: String,
        desc: "Specify configuration file",
        default: "config.yml"

      run do |opts, args|
        puts version
        puts "#{args.all_args.join(", ")}!"

        # Configuration
        begin
          config = Totem.from_file opts.config
        rescue Totem::Exception::NotFoundConfigFileError
          puts %(iobot: configuration file "#{opts.config}" not found)
          exit
        rescue exception
          puts "iobot: unhandled error in configuration"
          raise exception
        end

        client = Iolite::Client.new(
          server: config["uplink.server"].as_s?,
          port: config["uplink.port"].as_i?,
          password: config["uplink.password"].as_s?,

          nickname: config["irc.nickname"].as_s?,
          username: config["irc.username"].as_s?,
          realname: config["irc.realname"].as_s?
        )

        p client
      end
    end
  end
end

Iobot::CLI.start(ARGV) unless Iobot.responds_to?(:should)
