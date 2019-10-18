module Ykani
    module Util
        extend self

        def escaped_split(string : String, splitter : String)
            if string.index("\\#{splitter}")
                return string.split(/#{splitter}(?<!\\#{splitter})/)
            end
            return string.split(splitter)
        end
    end
end