module Ykani
    module Util
        extend self

        # Splits the text at every instance of the splitter, except for ones preceded by a "\"
        def escaped_split(string : String, splitter : String)
            if string.index("\\#{splitter}")
                return string.split(/#{splitter}(?<!\\#{splitter})/)
            end
            return string.split(splitter)
        end
    end
end