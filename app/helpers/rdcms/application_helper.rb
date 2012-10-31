module Rdcms
  module ApplicationHelper    
    include Rdcms::ArticlesHelper
    
    def s(name)
      if name.present?
        Rdcms::Setting.for_key(name)
      end
    end
    
  end
end
