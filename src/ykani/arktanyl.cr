module Ykani
    class Arktanyl
        getter data : Hash(String, Hash(String, String))
        getter file : String
        getter header : Hash(String, String)
        
        def initialize(filepath : String)
            @file = filepath
            raw = File.load(filepath)
            @header = get_header(raw)
            @data = get_data(raw)
        end

        private def get_header(data : String)
            raw = data.split("\n")[0..2]
            raw.each do |line|
                raw[raw.index(line)] = line.strip
            end
            return {"kv" => raw[0], "minor" => raw[1], "major" => raw[2]}
        end


    end
end
