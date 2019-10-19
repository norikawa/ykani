module Ykani
    module Forms
        extend self
        
        # Call the given form to build the page corrosponding to the given data
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