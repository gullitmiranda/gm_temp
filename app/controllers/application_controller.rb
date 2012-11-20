class ApplicationController < ActionController::Base

  before_filter :set_locale

  def set_locale
    unless Rails.env == "test"
      I18n.locale = session[:locale]
    end
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
end
