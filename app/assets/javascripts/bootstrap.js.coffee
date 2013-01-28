$.loadBootstrap = (options) ->
  options = $.extend true, {
    tooltip_options:
      placement: "bottom"
    }, options

  $("*[rel=popover]").popover(options.tooltip_options)
  $("*[rel=tooltip], .tooltip").tooltip(options.tooltip_options)

  return true

jQuery ->
  $.loadBootstrap()
