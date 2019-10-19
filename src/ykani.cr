require "./ykani/*"
require "./forms/*"

# Sets the location of the configuration .ini file, relative to ykani.cr
CONFIG_LOCATION = "./config.ini"

# Set the location of the Arktanyl directory, relative to ykani.cr
ARK_LOCATION = "./ark"

# TO-DO: Documentation 
module Ykani
  extend self
  
  # Sets the configuration file to be globally accessable from the Ykani module itself
  def config
    return Config.parse_ini(CONFIG_LOCATION)
  end
  
end

# Entry point for the server 
server = Ykani::Server.new(Ykani.config["server"]["ip"], Ykani.config["server"]["port"])