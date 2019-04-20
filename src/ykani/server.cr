module Ykani
  class Server
    getter address : String
    getter port : String
    
    def initialize(url)
      @address = Ykani.config["server"]["address"]
      @port = Ykani.config["server"]["port"]
      @url = Ykani.config["server"]["url"]
      @pagefile = Ykani::Arktanyl.new("#{ARK_LOCATION}/pages.ark")

    end

    private def render(page)
      if @pagefile[page]
        return hook_into_form(@pagefile[page]["TYPE"], @pagefile[page])
      else
        return hook_inti_form(@pagefile[
      end
    end

    private macro hook_into_form(form, page)
      return {{ form.id }}.hook(page)
    end
  end
end
