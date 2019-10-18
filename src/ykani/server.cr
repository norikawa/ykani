require "http"

module Ykani
    class Server 
        getter ip : String
        getter port : String
        #getter database = Ykani::Arktanyl.new("#{ARK_LOCATION}/pages.ark")
        #getter pagefile : Array(Hash(String, String))

        def initialize(ip, port)
            server = HTTP::Server.new do |context|
                database = Ykani::Arktanyl.new("#{ARK_LOCATION}/pages.ark")
                pagefile = database.data
                extension = context.request.path.split(".")[-1]
                path = context.request.path.split(".")[-2]? || "/"
                page = database.find_entry("URL", path) || pagefile[0]
                if context.request.method == "GET"
                    if extension == "html" || ""
                        context.response.content_type = "text/html"
                        form = page["FORM"] || "NorikawaStandard"
                        context.response.print(render(form, page))
                    else
                        context.response.content_type = mimetyper(extension)
                        #Resource Getter
                    end
                elsif context.request.method == "POST"
                    #Figure out what to do with this
                end
            end
            @ip = ip
            @port = port
            address = server.bind_tcp(ip, port.to_i)
            puts "[Ykani] Server Started on #{ip}:#{port}"
            server.listen
        end

        private def render(form, page) 
            return Ykani::Forms.run_form(form, page)
        end
        
        private def mimetyper(extension) 
            reference = Ykani::Arktanyl.new("#{ARK_LOCATION}/mimetypes.ark").find_entry("EXTENSION", extension)
            if reference    
                return reference["MIMETYPE"]
            else
                return "text/plain"
            end
        end
    end
end
