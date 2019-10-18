require "./ykani/*"
require "./forms/*"

CONFIG_LOCATION = "./config.ini"
ARK_LOCATION = "./ark"

module Ykani
  extend self
  
  def config
    return Config.parse_ini(CONFIG_LOCATION)
  end
  
end

server = Ykani::Server.new(Ykani.config["server"]["ip"], Ykani.config["server"]["port"])