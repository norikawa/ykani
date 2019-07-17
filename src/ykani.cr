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

page = Ykani::Arktanyl.new("./ark/pages.ark").data["root"]
page_test = NorikawaStandard.hook(page)
