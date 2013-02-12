class ApplicationController < ::ApplicationController
  before_filter :set_locale

  def set_locale
    unless Rails.env == "test"
      I18n.locale = session[:locale]
    end
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referrer
  end

  def after_sign_in_path_for(resource_or_scope)
    request.referrer
  end

  rescue_from CanCan::AccessDenied do |exception|
    if can?(:read, Article)
      redirect_to root_url, :alert => exception.message
    else
      redirect_to "/admin", :alert => exception.message
    end
  end

  def s(name)
    if name.present?
      Setting.for_key(name)
    end
  end

  private
  #Catcher for undefined Rdcms Callback Hooks
  def method_missing(meth, *args)
    unless [:before_init, :before_render, :after_init, :after_index].include?(meth.to_sym)
      super
    end
  end
end
