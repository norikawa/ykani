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
                path = context.request.path.split(".")[-2]? || context.request.path
                page = database.find_entry("URL", path) || pagefile[0]
                if context.request.method == "GET"
                    if mimetyper(extension) != "text/plain"
                        puts context.request.path
                        context.response.content_type = mimetyper(extension)
                        File.open("./resources/#{extension}#{path}.#{extension}") do |file|
                            IO.copy(file, context.response)
                        end
                    else
                        context.response.content_type = "text/html"
                        form = page["FORM"] || "NorikawaStandard"
                        context.response.print(render(form, page))
                    end
                elsif context.request.method == "POST"
                    #Figure out what to do with this

                else
                    puts context.request.path
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
