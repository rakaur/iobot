require "./spec_helper"

describe Configuration do
  # TODO: Write tests

  describe "General" do
    it "uses the default configuration file" do
      Configuration.new.config_file.should eq Configuration::DEFAULT_FILE
    end

    it "uses the configuration file passed on new" do
      Configuration.new("shard.yml").config_file.should eq "shard.yml"
    end

    it "raises exception on a bad file" do
      expect_raises(Configuration::ParseError) do
        Configuration.new("bad_file")
      end
    end
  end
end
