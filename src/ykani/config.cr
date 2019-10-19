# The Config submodule deals with parsing the configuration .ini file to a Crystal data structure
# The structure is a Hash of String => Hash(String, String), with the first String representing the title of a section and the Hash representing the data inside it


module Ykani::Config
  extend self

  # Parses a given file as a .ini, returning the appropriate Crystal data structure
  def parse_ini(file)
    results = Hash(String, Hash(String, String)).new 
    File.read(file).split("[").each do |section|
      if section == ""
        next
      end
      section_hash = Hash(String, String).new
      section_title = String.new
      section.strip.split("\n").each do |line|
        line = line.strip
        if line.index("]")
          section_title = line.rchop("]")
        else
          split_line = line.split("=")
          split_line[0] = split_line[0].strip
          split_line[1] = split_line[1].strip
          section_hash[split_line[0]] = split_line[1]
        end
      end
      if section_title == ""
        section_title = "Untitled"
      end
      results[section_title] = section_hash
    end
    return results
  end
end
