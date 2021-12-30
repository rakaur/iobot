class Configuration
  getter config_file

  DEFAULT_FILE = "config.yml"

  def initialize(file = DEFAULT_FILE)
    @config_file = file
    @config = nil

    begin
      @config = YAML.parse(File.read(@config_file))
    rescue
      raise Configuration::ParseError.new
    end
  end

  def config
    @config
  end

  class ParseError < Exception; end
end
