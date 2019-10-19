# The server class is responsible for all HTTP responses and requests, and thus is the heart of Ykani
# A new Server instance requires an IP and a Port to bind to, and then proceeds to set up the relevant data, and handle requests

require "http"

module Ykani
    class Server 
        getter ip : String
        getter port : String

        def initialize(ip, port)
            server = HTTP::Server.new do |context|

                # The pages.ark file is processed
                database = Ykani::Arktanyl.new("#{ARK_LOCATION}/pages.ark")

                # The data in the pages.ark is stored
                pagefile = database.data
                # The file extension, if any, is determined
                extension = context.request.path.split(".")[-1]

                # The filepath is determined. If it can not be determined, it is simply set to the request's path
                path = context.request.path.split(".")[-2]? || context.request.path

                # The page being requested is determined. If the appropriate page does not exist, the first page in the database is used instead (Thus, the first page in pages.ark should always be made an error page to catch these cases)
                page = database.find_entry("URL", path) || pagefile[0]

                # If the request method is GET:
                if context.request.method == "GET"

                    # If the extension was determined and its mimetype is known to the system, the request is treated as a file request
                    if mimetyper(extension) != "text/plain"

                        # The content type of the response is set to the appropriate mimetype
                        context.response.content_type = mimetyper(extension)

                        # The requested file is found, and sent as the respnse body
                        # NOTE: If the file does not exist, nothing with be sent, and Crystal will produce an error
                        File.open("./resources/#{extension}#{path}.#{extension}") do |file|
                            IO.copy(file, context.response)
                        end

                    # Else, if the extension was not determined, or its mimetype is not known, the request is treated as a page request
                    else

                        # The content type is set to HTML
                        context.response.content_type = "text/html"

                        # The page data for the request is checked for Form information, or otherwise set to NorikawaStandard
                        form = page["FORM"] || "NorikawaStandard"

                        # The page is rendered, and the HTML is sent as the response body
                        context.response.print(render(form, page))
                    end
                elsif context.request.method == "POST"
                    #Nothing happens for POST requests yet

                else
                    #If the request is neither GET nor POST, the request is printed for debugging
                    puts context.request
                end
            end
            @ip = ip
            @port = port
            address = server.bind_tcp(ip, port.to_i)
            puts "[Ykani] Server Started on #{ip}:#{port}"
            server.listen
        end

        # Given the name of a form, and the data of a page, render the page as HTML (in text)
        private def render(form, page) 
            return Ykani::Forms.run_form(form, page)
        end
        
        # Given an extension, determine the appropriate mimetype, or return text/plain if it cannot be determined
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
