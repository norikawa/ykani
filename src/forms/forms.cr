module Ykani
    module Forms
        extend self
        
        def run_form(form, data)
            case form
            when "NorikawaStandard"
                return NorikawaStandard.hook(data)
            else
                return NorikawaStandard.hook(data)
            end
        end
    end
end