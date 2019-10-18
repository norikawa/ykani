module Ykani
    class Arktanyl
        getter data : Array(Hash(String, String))
        getter header : Hash(String, String)
        getter filename : String
        
        def initialize(filepath : String)
            @filename = filepath
            raw = File.read(filepath)
            @header = get_header(raw)
            @data = get_data(raw)
        end

        private def get_header(data : String)
            raw = data.split("\n")[0..2]
            raw.each do |line|
                index = raw.index(line)
                if index
                    raw[index] = line.strip
                end
            end
            return {"kv" => raw[0], "minor" => raw[1], "major" => raw[2]}
        end

        private def get_data(data : String) 
            table_buffer = Array(Hash(String, String)).new
            raw = Ykani::Util.escaped_split(data, @header["major"])[1..]
            raw.pop
            raw.each do |entry|
                kv = @header["kv"]
                entry_buffer = Hash(String, String).new
                split_entry = Ykani::Util.escaped_split(entry, @header["minor"])
                split_entry.each do |property|
                    split_property = Ykani::Util.escaped_split(property, @header["kv"])
                    key = split_property[0].strip.gsub(/(\\#{@header["kv"]})/,kv)
                    value = split_property[1].strip.gsub(/(\\#{@header["kv"]})/,kv)
                    entry_buffer[key] = value
                end
                table_buffer << entry_buffer
            end
            return table_buffer
        end

        def find_entry(key : String, value : String)
            @data.each do |entry|
                if entry[key] == value
                    return entry
                end
            end
            return nil
        end
    end
end
