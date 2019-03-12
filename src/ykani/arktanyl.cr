module Ykani
  class Arktanyl
    @data = {} of String => Hash(String, String)
    @db_title = String.new

    def initialize(db_file : String)
      @db_file = db_file
      @db_title = db_file.split(".")[0].to_s.strip
      load_file(@db_file, @data)
    end

    private def load_file(file, data_loc)
      data = File.read(file)
      newline_split = data.split("\n")
      keyvalue_sep = newline_split[0].strip
      minor_sep = newline_split[1].strip
      major_sep = newline_split[2].strip
      split_data = data.strip.split(major_sep)
      split_data.shift
      split_data.pop
      split_data.each do |entry|
        temp = Hash(String, String).new
        entry_id = String.new
        id? = false
        entry.split(minor_sep).each do |property|
          property_data = property.split(keyvalue_sep)
          property_data.each do |item|
            property_data[property_data.index(item) || 0] = item.strip
            if item.strip == "ID"
              id? = true
            end
          end
          if id? == true
            entry_id = property_data[1]
            id? = false
          else
            temp[property_data[0]] = property_data[1]
          end
        end
        data_loc[entry_id] = temp
      end
    end

    def db_file
      @db_file
    end

    def db_title
      @db_title
    end

    def data
      @data
    end
  end
end
