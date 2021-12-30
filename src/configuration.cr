class Configuration
  getter config_file

  DEFAULT_FILE = "config.yml"

  def initialize(file = DEFAULT_FILE)
    @config_file = file
  end

  def parse
    @@config = File.open(@config_file) do |file|
      YAML.parse(file)
    end.as(YAML::Any)
  rescue
    raise Configuration::ParseError.new
  end

  def self.config
    @@config
  end

  class ParseError < Exception; end
end
