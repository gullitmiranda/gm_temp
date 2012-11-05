module ApplicationHelper    
  include ArticlesHelper
  
  def s(name)
    if name.present?
      Setting.for_key(name)
    end
  end
  
  def bugtracker
    user_mod = Setting.for_key("rdcms.bugherd.user")
    role_mod = Setting.for_key("rdcms.bugherd.role")
    bugherd_api = Setting.for_key("rdcms.bugherd.api")
    if bugherd_api.present? && user_mod.present? && role_mod.present? && eval("#{user_mod} && #{user_mod}.has_role?('#{role_mod}')")
      render :partial => "articles/bugherd", :locals => {:bugherd_api => bugherd_api}
    end
  end
end
