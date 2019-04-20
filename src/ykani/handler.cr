module Ykani
  class Handler
    getter url : String
    getter mimetypes : Array(Hash(String, String))

    def initialize(url)
      @url = url
      @mimetypes = Ykani::Arktanyl.new("../../ark/mimetypes.ark")
      extension = url.split(".")[1]
      @mimetypes.each do |entry|
        if entry["EXTENSION"] == extension
          #we know the mimetype, treat accordingly
          if extension == ".html" || ""
            #render page
          else
            #send file
          end
          break
        end
      end
    end
  end
end

