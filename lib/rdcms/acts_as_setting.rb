module Rdcms
    module ActsAsSetting
        module Controller
          
            def s(name)
              if name.present?
                Setting.for_key(name)
              end
            end
            
        end
    end
end
       
::ActionController::Base.send :include, Rdcms::ActsAsSetting::Controller
