# (->
#   $(document).ready ->
#     $("div.control-group").focusout ->
#       $(this).addClass "success"  unless $("div.control-group").hasClass("error")
# ).call this

builder=
  options: {
    wrapper_tag: ".control-group"
    error_tag: "label"
    error_class: "help-inline"
    wrapper_error_class: "error"
    wrapper_success: "success"
  }
  
  add: (element, settings, message) ->
    settings = $.extend {}, this.options, settings

    if element.data("valid") isnt false
      wrapper = element.closest(settings.wrapper_tag)
      wrapper.removeClass settings.wrapper_success
      wrapper.addClass settings.wrapper_error_class

      wrapper.append $("<" + settings.error_tag + "/>",
        class: settings.error_class
        text: message
        for: element.attr 'id' || ''
      )
    else
      wrapper = element.closest(settings.wrapper_tag)
      wrapper.addClass settings.wrapper_error_class
      element.parent().find("" + settings.error_tag + "." + settings.error_class).text message

  remove: (element, settings) ->
    settings = $.extend {}, this.options, settings
    
    wrapper = element.closest("" + settings.wrapper_tag + "." + settings.wrapper_error_class)
    wrapper.removeClass settings.wrapper_error_class
    wrapper.addClass settings.wrapper_success
    
    errorElement = wrapper.find("" + settings.error_tag + "." + settings.error_class)
    errorElement.remove()

window.ClientSideValidations.formBuilders["FormtasticBootstrap::FormBuilder"] = builder
window.ClientSideValidations.formBuilders["ActionView::Helpers::FormBuilder"] = builder
