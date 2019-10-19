module Ykani
    # Arktanyl is the data format utilized by Ykani.
    # An instance of the Arktanyl class contains the data of an Arktanyl file
    class Arktanyl
        getter data : Array(Hash(String, String))
        getter header : Hash(String, String)
        getter filename : String
        
        # Sets the instance's filename variable to the given filepath
        # Sets the instance's header variable to that of the given file
        # Sets the data variable of the instance to a parsed version of the given .ark file
        def initialize(filepath : String)
            @filename = filepath
            raw = File.read(filepath)
            @header = get_header(raw)
            @data = get_data(raw)
        end

        # Takes the text of a .ark file as input, and outputs a Hash where each Key/Value pair represents the delimiters of the file
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

        # Takes the text of a .ark file as input and outputs an Array containing a Hash for each Entry
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

        # Searches for the first entry with the given value for the given key
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
